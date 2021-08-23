$TimeSpan = New-TimeSpan -Days 0 -Hours 0 -Minutes 5
$Time = (Get-Date) - $TimeSpan


Get-EventLog -LogName System -Source "Service Control Manager" -After $time | where {$_.eventID -eq 7011}

#Write-Output $Time