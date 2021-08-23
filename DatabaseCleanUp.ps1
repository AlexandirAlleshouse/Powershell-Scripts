Add-Type -AssemblyName PresentationFramework

###Variables 
$currentusername = "rm12test-m1"
$CentralServicesURL = "ENTER SERVICES URL"
try
    {
        Import-Module 'C:\Program Files (x86)\WindowsPowerShell\Modules\MySQL'
    }
    catch
    {
    [System.Windows.MessageBox]::Show("Unable to Import the MySQL module")
    Exit
    }
    try
{
$username = "rmuc-starter"
$password = "jf2hQXbWa2zEHFT4"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd 


Connect-MySqlServer  -Credential $creds -ComputerName 'appdb.uc.rentmanager.com' -Database rmcustomer 9i
$global:currentclasses = @(Invoke-MySqlQuery  -Query "SELECT r.Class_Full_Name, c.EntID from rmuc_classes r left join company_new c on c.CompanyID = r.Class_ID where r.Presenter = '$env:username'")
$MySQLConnection.Close()
}
catch
{
[System.Windows.MessageBox]::Show("Unable to connect to the MySQL server to determine class enrollment")
Exit
}


#Connect to Central Services to look up account information to get the companyaccountid so we can do a lookup on the company 

$CentralSvcCustomerRequest = "$CentralServicesURL/corporate/companyusers?filters=RMOUsername,eq,$currentusername&embeds=CompanyAccount"
#This invokes the web request to central services and calles the powershell convert from JSON 

$UserInfo = Invoke-WebRequest $CentralSvcCustomerRequest | ConvertFrom-Json 

#This loads the JSON arrays so we can use them 
$userInfo[0] 

# Main JSON Output 
$userInfo.CompanyAccount[0] 
#Load the Company Account
#Sets the variable $CompanyName and CompanyAccountID so we can use them later 
$CompanyAccountID = $UserInfo | where { $_.RMOUsername -eq "$currentusername" } | Select -ExpandProperty CompanyAccountID
$CompanyName = $UserInfo.CompanyAccount | Select -ExpandProperty CompanyName

echo $CompanyAccountID
echo $CompanyName
