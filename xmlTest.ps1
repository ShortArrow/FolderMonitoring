# https://docs.microsoft.com/en-us/windows/uwp/design/shell/tiles-and-notifications/adaptive-interactive-toasts
# https://nyanshiba.hatenablog.com/entry/2018/03/16/014246
# https://docs.microsoft.com/ja-jp/dotnet/api/system.xml.xmlnode.appendchild?view=netframework-4.7.2
# https://docs.microsoft.com/en-us/windows/uwp/design/shell/tiles-and-notifications/toast-xml-schema

    $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    

    $doc=[System.Xml.XmlDocument]

    $root = [System.Xml.XmlNode]
    $root =$doc.DocumentElement;

    #Create a new node.
    $elem= [System.Xml.XmlElement]
    elem.InnerText="19.95";

    #Add the node to the document.
    root.AppendChild(elem);


    #XmlDocument�N���X���C���X�^���X��
    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    #LoadXml���\�b�h���Ăяo���A�ϐ�template��WinRT�^��xml�Ƃ��ēǂݍ���
    $aaa=[System.Xml]
    $xml.AppendChild("toast")
    $xml.CreateElement("div")
    Write-Output $xml.GetXml() | Out-File "xmltest.xml"
    # $xml.SaveToFileAsync("xmltest.xml")