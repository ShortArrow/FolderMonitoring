# 複数フォルダを指定できる設計になっています(配列)。
$FoldersConfigPath = ".\config\folders-settings.cfg"
$ExtensionsConfigPath = ".\config\extensions-settings.cfg"
$DIRS = (Get-Content $FoldersConfigPath) -as [string[]]
$EXTS = (Get-Content $ExtensionsConfigPath) -as [string[]]
$errorMessage = ""
$obj = @() 
foreach ($DIR in $DIRS) {
    if (Test-Path $DIR) {
        $finderPath = ("FileSystem::$DIR") # dir $DIR/hoge.xlsx にすれば、hogxlsxファイルだけに絞れます
        Write-Output "<$finderPath>"
        $Folders = (Get-ChildItem $finderPath | Where-Object { $_.GetType().Name -eq "DirectoryInfo"}) -as [string[]]
        $Files = ( Get-ChildItem $finderPath | Where-Object { $_.GetType().Name -eq "FileInfo" }) -as [string[]]
        $hashs = @()
        foreach ($item in $Files) {
            $hashs+=@{index=$hash.Count;item=$item;make= "2019/02/01";delete= $null;none=$false}
        }
        $obj += @{index = $obj.Count; path = $DIR; Files = $hashs; Folders = $Folders }
        # $obj | Add-Member $obj1 -Name $DIR -MemberType NoteProperty
    }
    else {
        # フォルダの存在確認
        if ($errorMessage -eq "") {
            $errorMessage += $DIR
        }
        else {
            $errorMessage += ",`r`n" + $DIR
        }
    }
}
# アセンブリの読み込み
Add-Type -Assembly System.Windows.Forms
# エラー表示
if ($errorMessage -ne "") {
    [System.Windows.Forms.MessageBox]::Show( `
            "「$errorMesge」 は`r`nアクセスできません", `
            "GFモニタリング！")
}
Remove-Item .\log\oldlog.json -Force
Rename-Item -NewName oldlog.json -Path .\log\newlog.json -Force
$obj | ConvertTo-Json -Depth 5 | Out-File .\log\newlog.json -Encoding default

# $newlog = Get-Content .\log\newlog.json -Encoding Default -Raw | ConvertFrom-Json
# $oldlog = Get-Content .\log\oldlog.json -Encoding Default -Raw | ConvertFrom-Json

# foreach ($item in $oldlog) {
#     Write-Output $item
# }