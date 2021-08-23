[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
(New-Object System.Drawing.Text.InstalledFontCollection).Families | Out-File C:\Users\aalleshouse\Desktop\fonts.txt

$TerminalServer = $env:COMPUTERNAME

Write-Output $env:COMPUTERNAME" has these extra or missing fonts when compared with RDS02"
Compare-Object (get-content 'C:\Users\aalleshouse\Desktop\fonts.txt') (get-content '\\tsclient\C\tmp\fontsrds2.txt') |Out-File \\tsclient\C\tmp\"Terminal Server Fonts"\${TerminalServer}" fonts compared to RM12-RDS02".txt
