#RMOChartsUptime Check
#Alexandir Alleshouse

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

$CURRENTDATE=GET-DATE -format yyyy-MM-dd

Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.lcs.com' -Database systems |Out-null

$RMOUpTime = @(Invoke-MySqlQuery  -Query "SELECT * FROM systems.systems_logs WHERE systems_logs.Service = 'RMOCharts_Uptime' AND systems_logs.Output = 'Successfully Connected to MySQL Zeroed out the totals' AND systems_logs.StartTimeStamp > '$CurrentDate';")
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
foreach ($ComputerName in $RMOUpTime)
{
    if ($RMOUpTime.computer_name -eq $null)
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
    echo "The RMOCharts_UpTime service successfully connected to MySQL and zeroed out the totals."
    exit 0
}
else 
{
    echo "The RMOCharts_UpTime servicefailed to successfully connect to MySQL and zero out the totals."
    exit 1
}
