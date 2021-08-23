Function UpdateLoggingAPI ($message) {
 
try{
$Service = "Mapped Drives Check"
$OutPut = $message
$StartTimeStamp = (get-date).ToString("yyyy-MM-dd HH:mm:ss")
$EndTimeStamp = (get-date).ToString("yyyy-MM-dd HH:mm:ss")
 
$postParams = @{computername=$env:computername;service=$Service;output=$output;starttimestamp=$StartTimeStamp;endtimestamp=$EndTimeStamp}
 
Invoke-WebRequest -Uri https://systems_logging.lcs.com/logging.php -Method POST -Body $postParams
}
catch{
echo "Unable to update log server"
}
 
}


function Get-TSSessions {
    param(
        $ComputerName = "$env:computername"
    )
 
    qwinsta /server:$ComputerName |
    #Parse output
    ForEach-Object {
        $_.Trim() -replace "\s+",","
    } |
    #Convert to objects
    ConvertFrom-Csv
}
  
$drives = "ZZ:/"
$Check=Test-Path $drives
function Start-RDP ($computername, $username, $password)
{
    Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$computername"
    $cmdkey = cmdkey /generic:TERMSRV/$computername /user:rmo\$username /pass:$password
    New-PSDrive -Name "ZZ" -PSProvider "FileSystem" -Root "\\tsclient\C\Users\Public"
    #$Drives=Get-WmiObject -Class Win32_MappedLogicalDisk | select Name, ProviderName
    $Check=Test-Path $drives

}

If ($Check -eq "True") {
     echo  $env:COMPUTERNAME" is able to map drives"
     exit 1
     } 
     
     Else 
     
     {
     echo $env:COMPUTERNAME" is not able to map drives"
     exit 2
     }


