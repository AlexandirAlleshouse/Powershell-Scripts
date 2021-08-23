############################################################################################
#
#Slam Duncan
#March 2017
#
#Emergency connect to each RMO Server Script 
#
#############################################################################################
#############################################################################################
#############################################################################################
Import-Module MySQL
$username = "systems-user"
$password = "uhjnTR87CD"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd


Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.lcs.com' -Database rmcustomer
$result = @(Invoke-MySqlQuery  -Query 'SELECT ServerName FROM rmoserver ORDER BY ServerName ASC') |select-object -expand ServerName
$MySQLConnection.Close()


#Loop through results from APPDB and Do Whatever

foreach ($item in $result) {
    $domain = "rmo.rentmanager.com"
    $servername = "$item.$domain"
    try{
        Write-Host "Connecting to $servername"
        Invoke-Command -Computername $servername -Scriptblock {gpupdate.exe} -ErrorAction stop
        Write-Host "GP updated successfully." 
    }
    Catch
    {
        Write-Host "Could not connect to $servername"

    }
    
}


    