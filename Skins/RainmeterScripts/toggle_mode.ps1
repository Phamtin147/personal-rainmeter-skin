$stateFile = "C:\Users\Amtia\Documents\Rainmeter\Skins\RainmeterScripts\current_mode.txt"

if (Test-Path $stateFile) {
    $current = [int](Get-Content $stateFile)
} else {
    $current = 3
}

switch ($current) {
    1 { $next = 2 }
    2 { $next = 3 }
    3 { $next = 1 }
    default { $next = 2 }
}

$wmi = Get-WmiObject -Namespace "root\WMI" -Class "LENOVO_GAMEZONE_DATA"
$wmi.SetSmartFanMode($next)

$next | Out-File $stateFile -Force