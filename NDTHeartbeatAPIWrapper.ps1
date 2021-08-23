
$postParams = @{computername=$env:computername;service=$Service;output=$output;starttimestamp=$StartTimeStamp;endtimestamp=$EndTimeStamp}

Invoke-WebRequest -Uri https://systems_logging.lcs.com/logging.php -Method POST -Body $postParams
}
catch{
echo "Unable to update log server"
}

}

#variables
$attempts=0


#Starts NDT Heartbeat check
$NDTConnections= cmd /c C:\nagios\ndtservice-heartbeat.exe 2>&1
#Stores Heartbeat exit code
$exit = CMD /C "echo %errorlevel%"
#echo "$exit is good"


#Evaluates exit code
if ($exit -eq 0)
{echo "all good"
echo $NDTConnections
exit 0
}
elseif ($exit -ne 0)
{
Start-Sleep -s 30
$NDTConnections= cmd /c C:\nagios\ndtservice-heartbeat.exe 2>&1
#Stores Heartbeat exit code
$exit = CMD /C "echo %errorlevel%"
$attempts=1
}

if ($exit -ne 0 -and $attempts -gt 0)
{
#Restarts NDT Service
Restart-Service "NDTService"
$output = "The NDT Service encountered an issue. NDT Service was restarted"
UpdateLoggingAPI($output)
echo $output
Send-MailMessage -To "NDT Team <ndt-service@lcs.com>" -From "NDTServiceBot <NDTServiceHeartbeat@lcs.com>" -Subject "NDT Service was restarted" -body "$output" -SmtpServer "mail.rentmanager.com"
exit 1
}
else
{echo "all good"
echo $NDTConnections
exit 0
}