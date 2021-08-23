#Imports Active Directory
Import-Module ActiveDirectory

#Requests User Input for XI Server
$RMOSERVERS = @("RMO27","RMO28","RMO29","RMO32","RMO-V01","RMO-V02","RMO-V03","RMO-V04","RMO-V05","RMO-V06","RMO-V07","RMO-V08","RMO-V09","RMO-V10","RMO-V11","RMO-V12","RMO-V13","RMO-V14","RMO-V15")

#Loops through servers in array
foreach ($server in $RMOSERVERS)
{

    $server
    #Counts Total Number of groups associated with the TSPrint Group
    $TSPrintMembers= Get-ADGroupMember -identity "TSprint Group" -server rmodc1.rmo.rentmanager.com | SELECT -ExpandProperty Name

    #Pulls list of users associated with a terminal server
    $TerminalServerMembers= Get-ADOrganizationalUnit -Filter * -server rmodc1.rmo.rentmanager.com -SearchBase "OU=$server,OU=Users,OU=RMO,DC=rmo,DC=rentmanager,DC=com" | SELECT -ExpandProperty Name

    #Counter for Loop
    $c = 0

    #Loops through list of members associated with terminal server and compares it to the members who use TSPrint
    Foreach ($x in $TerminalServerMembers)

    { 

        if ($TSPrintMembers.Contains($x))
        {
        $c++
            } 
    }

    #Stores total number of members on terminal server
    $total = $TerminalServerMembers.count

    #Subtracts total number of TSprint members from total members associated with the terminal server
    $EasyPrint = $total - $c
    $PercentOfServer = ($EasyPrint / $total).tostring("P")

    #Prints Results
    echo "On $server there are $total members total on this server, $c of which are TSPrint enabled. There are $EasyPrint members still using Easy Print on this server. This is $PercentOfServer of the server. "

}


