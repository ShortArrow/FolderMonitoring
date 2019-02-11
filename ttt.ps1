Function Toast {
    #AppID���ׂ�:Get-StartApps
    $AppId = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"

    #���[�h�ς݈ꗗ:[System.AppDomain]::CurrentDomain.GetAssemblies() | % { $_.GetName().Name }
    #WinRTAPI���Ăяo��:[-Class-,-Namespace-,ContentType=WindowsRuntime]
    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    
    #XmlDocument�N���X���C���X�^���X��
    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    #LoadXml���\�b�h���Ăяo���A�ϐ�template��WinRT�^��xml�Ƃ��ēǂݍ���
    $template= Get-Content -Path template.xml -Raw
    $xml.LoadXml($template)

    #ToastNotification�N���X��CreateToastNotifier���\�b�h���Ăяo���A�ϐ�xml���g�[�X�g
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($xml)
}

#hint-crop="circle"
# <image placement="hero" src="C:\DTV\racia\00285_toast.png"/>
Toast
exit