$StartTimeStamp = (get-date).ToString("yyyy-MM-dd HH:mm:ss")  

    Function UpdateLoggingAPI ($message) {
 
try{
$Service = "Mapped Drives Check"
$OutPut = $message

$EndTimeStamp = (get-date).ToString("yyyy-MM-dd HH:mm:ss")
 
$postParams = @{computername=$env:computername;service=$Service;output=$output;starttimestamp=$StartTimeStamp;endtimestamp=$EndTimeStamp}
 
Invoke-WebRequest -Uri https://systems_logging.lcs.com/logging.php -Method POST -Body $postParams
}
catch{
echo "Unable to update log server"
}
 
}



    Function MapDriveTest {
    Param(
    [string]$DriveName, 
    [string]$DrivePath
    )
        try {
    New-PSDrive -Name $DriveName -PSProvider "FileSystem" -Root $DrivePath
    
    $Check=Test-Path $DriveName
    
    If ($Check -eq "True") {
     $global:message = "$env:COMPUTERNAME is able to map local drives"
        } 
     }
    
     catch {
            $message = "This is not working"
            UpdateLoggingAPI $message
            exit
    }

           }


$Job = Start-Job -ScriptBlock {MapDriveTest -DriveName N -DrivePath \\tsclient\users\public\}






<#

$output = ""
MapDriveTest -DriveName N: -Drivepath \\tsclient\blah

if($global:message -ne "$env:COMPUTERNAME is able to map local drives")
{
$output+="Failed to map tsclient"
}

$global:message = ""

MapDriveTest -DriveName z: -Drivepath \\cifs_rmo\blah

if($global:message -ne "$env:COMPUTERNAME is able to map local drives")
{
$output+="Failed to map cifs_rmo"
}

if($output -ne "")
{
UpdateLoggingAPI ("$output")
}

Start
#>