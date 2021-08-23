#Allows for use of Active Directory objs
Import-Module activedirectory

#Create array for list of objects to be acted upon
$computers = @("RMOREMOTEAPP","RMUC-RDS02","RM12-RDS-REMOTE","RMUC-RDS01","MODERNTS2016","RM12-TEST","RMUC01","RM12-HO01","RMO-CB01","RMO24","RMO-V17","RMO-V18","RM12-RDSTEST","RMO-V16")

#For loop called Foreach in PS, loops through use {} for action
foreach($x in $computers)
{
#Action
Remove-ADComputer -Identity $x -Confirm:$false -server RMODC1.rmo.rentmanager.com
}