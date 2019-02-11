Function Balloon {
    #System.Windows.FormsクラスをPowerShellセッションに追加
    Add-Type -AssemblyName System.Windows.Forms
    #NotifyIconクラスをインスタンス化
    $balloon = New-Object System.Windows.Forms.NotifyIcon
    #powershellのアイコンを抜き出す
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe')
    #特定のTipIconのみを使用可
    #[System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property
    $balloon.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]::Warning
    #表示するメッセージ
    $balloon.BalloonTipText  = "\\192.168.0.170"
    #表示するタイトル
    $balloon.BalloonTipTitle = "ファイル変更通知"
    #タスクトレイアイコン表示
    $balloon.Visible = $True
    #1000ミリ秒表示
    $balloon.ShowBalloonTip(1000)
    #1秒待ってからタスクトレイアイコン非表示
    Start-Sleep -Seconds 10
    $balloon.Visible = $False
}

Balloon

Exit