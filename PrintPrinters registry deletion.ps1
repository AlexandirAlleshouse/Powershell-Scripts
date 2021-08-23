Set-Location "HKLM:\system\CurrentControlSet\Control\Print\Printers"
$keys = @(gci)

$keyCountBefore = (gci).count

Foreach ($key in $keys) {
	$keyPath = $key.PSPath
    #write-host $keypath
	#$values = Get-ItemProperty $keyPath"\Device Parameters"

	If ($keypath -eq "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\system\CurrentControlSet\Control\Print\Printers\Your Default Printer") {
        continue		
#Remove-Item -recurse $key.PSPath
		}
	ElseIf ($keypath -eq "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\system\CurrentControlSet\Control\Print\Printers\Your Other Printers") {
        continue		
#Remove-Item -recurse $key.PSPath
		}
	ElseIf ($keypath -eq "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\system\CurrentControlSet\Control\Print\Printers\Your Legal Printer") {
        continue		
#Remove-Item -recurse $key.PSPath
		}
	Else  {
        write-host $keypath	
        Remove-Item -recurse $key.PSPath
		}
	}