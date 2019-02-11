Function Toast {
    #AppID調べる:Get-StartApps
    $AppId = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"

    #ロード済み一覧:[System.AppDomain]::CurrentDomain.GetAssemblies() | % { $_.GetName().Name }
    #WinRTAPIを呼び出す:[-Class-,-Namespace-,ContentType=WindowsRuntime]
    $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    
    #XmlDocumentクラスをインスタンス化
    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    #LoadXmlメソッドを呼び出し、変数templateをWinRT型のxmlとして読み込む
    $xml.LoadXml($template)

    #ToastNotificationクラスのCreateToastNotifierメソッドを呼び出し、変数xmlをトースト
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($xml)
}

#トーストテンプレート大きい画像を付けて5秒間表示する
$template = @"
<toast duration="5" >
    <visual>
        <binding template="ToastGeneric">
            <text>チェック君</text>
            <text>オーナー、宜しければ一緒にお茶をいかがですか？</text>
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
        #5つまで
        <input id="snoozeTime" type="selection" defaultInput="3">
            <selection id="3" content="3 minutes" />
            <selection id="5" content="5 minutes" />
            <selection id="10" content="10 minutes" />
            <selection id="15" content="15 minutes" />
            <selection id="30" content="30 minutes" />
        </input>
        <action activationType="system" arguments="snooze" hint-inputId="snoozeTime" content="また誘って"/>
        <action activationType="system" arguments="dismiss" content="やだ"/>
    </actions>
</toast>
"@
#hint-crop="circle"
# <image placement="hero" src="C:\DTV\racia\00285_toast.png"/>
Toast
exit