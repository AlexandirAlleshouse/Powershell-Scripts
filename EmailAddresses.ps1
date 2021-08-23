#Make sure to load all properties then select the properties
Get-ADObject -Filter 'ObjectClass -eq "Contact"' -SearchBase 'OU=RMUC Contacts,DC=Cottonwood,DC=snohio,DC=net' -properties *| select Name, mail  | Export-CSV "C:\Scripts\Email_Addresses.csv"


