############################################################################################
#
# Ryan Bell
# January 2018
#
#Script to remotely run commands on rmo servers  
#
#############################################################################################
#############################################################################################
#############################################################################################
param([string]$Run)
Set-Location C:\Scripts\Powershell
#Import-Module MySQL
Import-Module MySQL
# Start MySQL Connection
$username = "systems-user"
$password = "uhjnTR87CD"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd
Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.lcs.com' -Database rmcustomer
$servers = @(Invoke-MySqlQuery  -Query 'SELECT ServerName FROM rmoserver where Active = 1 ORDER BY ServerName ASC') |select-object -expand ServerName
$MySQLConnection.Close()
# End MySQL
###########



###################
foreach($server in $servers){
.\PsExec.exe -h -n 10 -accepteula \\$server $Run
}


