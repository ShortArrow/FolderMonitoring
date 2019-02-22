# 複数フォルダを指定できる設計になっています(配列)。
$FoldersConfigPath = ".\folders-settings.cfg"
$ExtensionsConfigPath = ".\extensions-settings.cfg"
$DIRS = (Get-Content $FoldersConfigPath) -as [string[]]
$EXTS = (Get-Content $ExtensionsConfigPath) -as [string[]]
$errorMessage = ""
$obj = New-Object PSCustomObject 
foreach ($DIR in $DIRS) {
    if (Test-Path $DIR) {
        $finderPath = ("FileSystem::$DIR") # dir $DIR/hoge.xlsx にすれば、hoge.xlsxファイルだけに絞れます
        Write-Output "<$finderPath>"
        $Files = (Get-ChildItem $finderPath -File -Depth 0 -Name) -as [string[]]
        $Folders = ( Get-ChildItem $finderPath -Directory -Depth 0 ) -as [string[]]

        $obj1 = New-Object PSCustomObject 
        $obj1 | Add-Member -NotePropertyMembers @{
            Files   = $Files 
            Folders = $Folders
        } 
        $obj | Add-Member $obj1 -Name $DIR -MemberType NoteProperty 
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
            "「$errorMessage」 は`r`nアクセスできません", `
            "GFモニタリング！")
}
Remove-Item .\oldlog.json -Force
Rename-Item .\newlog.json .\oldlog.json -Force
$obj| ConvertTo-Json | Out-File .\newlog.json -Encoding default

$newlog = Get-Content .\newlog.json -Encoding Default -Raw | ConvertFrom-Json
$oldlog = Get-Content .\oldlog.json -Encoding Default -Raw | ConvertFrom-Json

# foreach ($item in $newlog[]) {
#     Write-Output $item
# }