
ipmo ScheduledTasks
$scriptPath = C:\Scripts\Powershell\OwlGamesTF.ps1
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\Scripts\Powershell\OwlGamesTF.ps1'
$trigger =  New-ScheduledTaskTrigger -Weekly -DaysOfWeek Thursday, Friday -At 18:55
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Week Day OWL Games" -Description "Watch OWL Games on Thursday * Friday" 

ipmo ScheduledTasks
$scriptPath = C:\Scripts\Powershell\OwlGamesTF.ps1
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\Scripts\Powershell\OwlGamesTF.ps1'
$trigger =  New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday, Sunday -At 14:55
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Weekend OWL Games" -Description "Watch OWL Games on Saturday & Sunday" 

ipmo ScheduledTasks
$scriptPath = C:\Scripts\Powershell\KillIE.ps1
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\Scripts\Powershell\KillIE.ps1'
$trigger =  New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday, Sunday -At 22:00
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Stop OWL Weekend" -Description "Kill IE on Saturday and Sunday"

ipmo ScheduledTasks
$scriptPath = C:\Scripts\Powershell\KillIE.ps1
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\Scripts\Powershell\KillIE.ps1'
$trigger =  New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday, Saturday -At 01:30
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Stop OWL Weekday" -Description "Watch OWL Games on Thursday and Friday"