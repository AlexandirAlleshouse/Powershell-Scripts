#Allows for use of Active Directory objs
Import-Module activedirectory

#Create array for list of objects to be acted upon
$RMUCUsers = Get-ADUser -Filter {name -like "rmuc*"} -server rmodc1.rmo.rentmanager.com | Select -ExpandProperty distinguishedname

#For loop called Foreach in PS, loops through use {} for action
foreach($x in $RMUCUsers)
{
#Action
Remove-ADObject -identity "$x" -Confirm:$false -server rmodc1.rmo.rentmanager.com
}


