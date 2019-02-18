#	===========================================================================
#	Created on:   5/28/2018 @ 03:55
#	Created by:   Alcha
#	Organization: HassleFree Solutions, LLC
#	Filename:     New-Notification.ps1
#	===========================================================================

Add-Type -AssemblyName System.Windows.Forms

function Show-Notification () {
    $NotifyIcon = New-Object -TypeName System.Windows.Forms.NotifyIcon
    $NotifyIcon.BalloonTipText = "Balloon tip text."
    $NotifyIcon.BalloonTipTitle = "Title of the balloon"
    $NotifyIcon.Visible = $true
    $NotifyIcon.add_BalloonTipClicked( { Start-Process 'notepad.exe' })
    $NotifyIcon.ShowBalloonTip(10000)
}
Show-Notification