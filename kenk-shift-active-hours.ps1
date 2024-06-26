function wlog ($sStr) {
    $sStr = (get-date).ToString("yyyy-MM-dd HH:mm:ss") + " " + $sStr
    $sStr | out-file ".\log.txt" -append
}
wlog ("starting $($MyInvocation.MyCommand.Path)")
$ActiveHoursStart =  (get-date).Hour
$ActiveHoursEnd = ($ActiveHoursStart + 18 ) % 24
wlog ("setting ActiveHoursStart to [$ActiveHoursStart] and ActiveHoursEnd to [$ActiveHoursEnd]")
New-Item -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ActiveHoursStart" -Value $ActiveHoursStart -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "UserChoiceActiveHoursStart" -Value $ActiveHoursStart -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ActiveHoursEnd" -Value $ActiveHoursEnd -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "UserChoiceActiveHoursEnd" -Value $ActiveHoursEnd -PropertyType DWord -Force
wlog ("end of $($MyInvocation.MyCommand.Path)")