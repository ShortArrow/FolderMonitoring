# Powershell version check
($PSVersionTable)["PSVersion"]
# Administrator authorization Check
if (-not(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" ))) {
    Write-Host "+++++++++ Administrator authorization is required +++++++++" -ForegroundColor White -BackgroundColor Red
    Write-Host "Install failured!!"
    Write-Host "You can close this window by anykey"
    return
}

$Action = New-ScheduledTaskAction `
    -Execute "C:\Windows\System32\notepad.exe"

$repeat = (New-TimeSpan -Minutes 1)

$Trigger = New-ScheduledTaskTrigger `
-At "00:00:00" -Once `
-RepetitionInterval $repeat #-RepeatIndefinitely
# -RepetitionDuration  (New-TimeSpan -Minutes 5)  `
# -RepeatIndefinitely
# -Daily -At "00:00:00" `

$taskSettings = New-ScheduledTaskSettingsSet -Hidden
$taskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" `
    -LogonType ServiceAccount -RunLevel Highest

$Task = New-ScheduledTask `
    -Principal $taskPrincipal `
    -Settings $taskSettings `
    -Trigger $Trigger `
    -Action $Action

Unregister-ScheduledTask -TaskName "GF"
Register-ScheduledTask -TaskName "GF" -Principal $taskPrincipal -Action $Action -Trigger $Trigger #-Settings $taskSettings
Start-ScheduledTask "GF"