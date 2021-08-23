###########################
##   RMDBCleanup Check  ###
## Alexandir Alleshouse ###
###########################

#Attempts to import MySQL module for PowerShell
try
    {
        Import-Module C:\Scripts\RMOCHARTS-RMOTS\MySQL-master\MySQL
    }
    catch
    {
    #[System.Windows.MessageBox]::Show("Unable to Import the MySQL module")
    #Exit
    }
    
#Connects to MySQL and passes through Query    
    try
{
$username = "systems-user"
$password = "uhjnTR87CD"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd 

$CURRENTDATE=GET-DATE -format yyyy-MM
$FIRSTDAYOFMONTH=GET-DATE $CURRENTDATE -Day 1 -format yyyy-MM-dd

Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.lcs.com' -Database systems |Out-null

$ActiveDBServers = @(Invoke-MySqlQuery  -Query "SELECT systems_logs.Computer_Name FROM systems.systems_logs WHERE systems_logs.Service = 'RMDB_Conversion_Cleanup' AND systems_logs.StartTimeStamp LIKE '%$FIRSTDAYOFMONTH%'")
$MySQLConnection.Close()

}
catch
{
#[System.Windows.MessageBox]::Show("Unable to connect to the MySQL server to determine class enrollment")
#Exit
}

#Connect to Central Services
$CentralSvcCustomerRequest = "https://centralservices.lcs.com/databaseservers?filters=IsActive,eq,True"

#Invokes the web request to central services and calls the powershell convert from JSON 
$UserInfo = Invoke-WebRequest $CentralSvcCustomerRequest | ConvertFrom-Json 

#loads the JSON arrays so we can use them 
$userInfo[0] | out-null
$dbservers = $UserInfo | Select -ExpandProperty DatabaseServerName

#Status Variable
$status=''
#List of db servers to be excluded in the check
$exclusionservers=@("moderndb1","rmdbtraining", "rmdbinternal")

#Loops thorugh each server in the array if the server is not on the exclusion list
foreach ($server in $dbservers)
{

    if ($exclusionservers.contains($server))
    {
        continue
    }
    #$server=$server.computer_name
    if ($ActiveDBServers.computer_name.Contains($server))
    {
        #echo "$server is in the array"
    }
    else
    {
        $status += $server + " did not run it's cleanup job this month. "
    }

   
}

#Status passing to Nagios

if ($status -eq '')
{
    echo "All server successfully completed their cleanup this month."
    exit 0
}
else 
{
    echo $status
    exit 1
}