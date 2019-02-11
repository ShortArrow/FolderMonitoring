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
    $xml.LoadXml($template)

    #ToastNotification�N���X��CreateToastNotifier���\�b�h���Ăяo���A�ϐ�xml���g�[�X�g
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($xml)
}

#�g�[�X�g�e���v���[�g�傫���摜��t����5�b�ԕ\������
$template = @"
<toast duration="5" >
    <visual>
        <binding template="ToastGeneric">
            <text>�`�F�b�N�N</text>
            <text>�I�[�i�[�A�X������Έꏏ�ɂ������������ł����H</text>
            <image placement="appLogoOverride" hint-align="center" src="C:\Users\take\Desktop\Monitor\img\detective.png"/>
            <image src="C:\Users\take\Desktop\Monitor\img\moncra.png"/>
            <text>Downloading your weekly playlist...</text>
            <progress
                title="Weekly playlist"
                value="0.6"
                valueStringOverride="15/26 songs"
                status="Downloading..."/>
    </binding>
    </visual>
    <actions>
        #5�܂�
        <input id="snoozeTime" type="selection" defaultInput="3">
            <selection id="3" content="3 minutes" />
            <selection id="5" content="5 minutes" />
            <selection id="10" content="10 minutes" />
            <selection id="15" content="15 minutes" />
            <selection id="30" content="30 minutes" />
        </input>
        <action activationType="system" arguments="snooze" hint-inputId="snoozeTime" content="�܂��U����"/>
        <action activationType="system" arguments="dismiss" content="�₾"/>
    </actions>
</toast>
"@
#hint-crop="circle"
# <image placement="hero" src="C:\DTV\racia\00285_toast.png"/>
Toast
exit