

$sPath = "$env:LOCALAPPDATA\kenk-shift-active-hours"
if (-not (test-path $sPath)) {
    New-Item $sPath -ItemType "directory"
}
copy-item ".\kenk-shift-active-hours.ps1" $sPath
copy-item ".\Hidden.vbs" $sPath
$sCMDFileContent = ('powershell.exe -file "' + "$sPath\kenk-shift-active-hours.ps1" +'"')
[IO.File]::WriteAllLines("$sPath\run-hidden.cmd", $sCMDFileContent)

$sVBSPath = "$sPath\Hidden.vbs"
$sCMDPath = "$sPath\run-hidden.cmd"
$sArgForTask = '"' + $sVBSPath + '" "' + $sCMDPath + '"'

$TaskSet = New-ScheduledTaskSettingsSet -Compatibility Win8
$TaskSet.DisallowStartIfOnBatteries = $True
$TaskSet.StopIfGoingOnBatteries     = $True
$TaskSet.IdleSettings.StopOnIdleEnd = $false
#Adjust the following two lines to meet your requirements
$sUserName = [Environment]::UserName

$TaskName = "shift-active-hours for $sUserName"
$TaskDesc = $TaskName
# $Stt = New-ScheduledTaskTrigger -Daily -At (Get-Date)
# $trigger = New-ScheduledTaskTrigger `
#     -Once `
#     -At (Get-Date) `
#     -RepetitionInterval (New-TimeSpan -Minutes 5) `
#     -RepetitionDuration ([System.TimeSpan]::MaxValue)


$action     = New-ScheduledTaskAction -Execute "wscript.exe" -Argument $sArgForTask -WorkingDirectory $sPath
$trigger    = New-ScheduledTaskTrigger -Daily -At 12am
$RSTArgs = @{Action      = $action
             TaskName    = $TaskName
             Trigger     = $trigger
             User        = "$env:USERDOMAIN\$env:username"
             Description = "$TaskDesc"
             Settings    = $TaskSet}
Unregister-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue -Confirm:$false

$task = Register-ScheduledTask @RSTargs
$task.Triggers.Repetition.Duration = "P1D"  #Repeat for a duration of one day
$task.Triggers.Repetition.Interval = "PT30M" #Repeat every 30 minutes, use PT1H for every hour
$task | Set-ScheduledTask

