Function Balloon {
    #System.Windows.Forms�N���X��PowerShell�Z�b�V�����ɒǉ�
    Add-Type -AssemblyName System.Windows.Forms
    #NotifyIcon�N���X���C���X�^���X��
    $balloon = New-Object System.Windows.Forms.NotifyIcon
    #powershell�̃A�C�R���𔲂��o��
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe')
    #�����TipIcon�݂̂��g�p��
    #[System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property
    $balloon.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]::Warning
    #�\�����郁�b�Z�[�W
    $balloon.BalloonTipText  = "\\192.168.0.170"
    #�\������^�C�g��
    $balloon.BalloonTipTitle = "�t�@�C���ύX�ʒm"
    #�^�X�N�g���C�A�C�R���\��
    $balloon.Visible = $True
    #1000�~���b�\��
    $balloon.ShowBalloonTip(1000)
    #1�b�҂��Ă���^�X�N�g���C�A�C�R����\��
    Start-Sleep -Seconds 10
    $balloon.Visible = $False
}

Balloon

Exit