#Allows for use of Active Directory objs
Import-Module activedirectory

#Create array for list of objects to be acted upon
$RMUCGroups = Get-ADGroup -Filter {name -like "rmuc*"} -server rmodc1.rmo.rentmanager.com | Select -ExpandProperty distinguishedname

#For loop called Foreach in PS, loops through use {} for action
foreach($x in $RMUCGroups)
{
#Action
Remove-ADGroup -Identity $x -Confirm:$false -server RMODC1.rmo.rentmanager.com
}

