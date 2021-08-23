#BlackListBotDaily Check
#Alexandir Alleshouse

#Attempts to import MySQL module for PowerShell
#Test MySQL connector
<#try
    {
        Import-Module C:\Scripts\Modules\MySQL
    }
    catch
    {
    #[System.Windows.MessageBox]::Show("Unable to Import the MySQL module")
    #Exit
    }
#>

#Actual MySQL connector
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

$CURRENTDATE=GET-DATE -format yyyy-MM-dd

Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.lcs.com' -Database systems |Out-null

$BlackListBotCount = @(Invoke-MySqlQuery  -Query "SELECT * FROM systems.systems_logs WHERE systems_logs.Service = 'IP_Blacklist_Bot' AND systems_logs.StartTimeStamp >'$CURRENTDATE';")
$MySQLConnection.Close()

}
catch
{
#[System.Windows.MessageBox]::Show("Unable to connect to the MySQL server to determine class enrollment")
#Exit
}

#Status Variable
$status=''


#Determines if SQL query is null and sets status
foreach ($ComputerName in $BlackListBotCount)
{
    if ($BlackListBotCount.computer_name -eq $null)
    {
        $status=2 
    }

    else
    {
        $status=1
      
    }
}


#Checks status and returns value to Nagios
If ($status -eq 1)
{
    echo "The BlackList Bot successfully ran today"
    exit 0
}
else 
{
    echo "The BlackList Bot failed to run today."
    exit 1
}
