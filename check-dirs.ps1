# 複数フォルダを指定できる設計になっています(配列)。
$FoldersConfigPath = ".\folders-settings.cfg"
$ExtensionsConfigPath = ".\extensions-settings.cfg"
$DIRS = (Get-Content $FoldersConfigPath) -as [string[]]
$EXTS = (Get-Content $ExtensionsConfigPath) -as [string[]]
# メインの処理
$errorMessage = ""
$resultMessage = ""
foreach ($DIR in $DIRS) {
    if (Test-Path $DIR) {
        $finderPath = ("FileSystem::$DIR") # dir $DIR/hoge.xlsx にすれば、hoge.xlsxファイルだけに絞れます
        Write-Output "[$finderPath]"
        $Folders = (Get-ChildItem $finderPath -Directory -Depth 0 ) -as [string[]]
        $Files = ( Get-ChildItem $finderPath -File -Depth 0 -Name) -as [string[]]
        if ($null -ne $Files.Length) {
            $FileCount = $Files.Length.ToString("#,0")
        }
        else {
            $FileCount = 0
        }
        if ($null -ne $Files.Length) {
            $FolderCount = $Folders.Length.ToString("#,0")
        }
        else {
            $FolderCount = 0
        }
        if (($FileCount -ne 0) -or ( $FolderCount -ne 0)) {
            $textBuffer = "「$DIR」 に"
            if ($FolderCount -ne 0) {
                $textBuffer += "`r`nフォルダが $FolderCount 個"
                if ($FileCount -ne 0) {
                    $textBuffer += "と"
                }
            }
            if ($FileCount -ne 0) {
                $textBuffer += "`r`nファイルが $FileCount 個"
            }
            $textBuffer += "あります。"
            if ($resultMessage -eq "") {
                $resultMessage += $textBuffer
            }
            else {
                $resultMessage += "`r`n" + $textBuffer
            }
        }
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
Add-Type -Assembly System.Windows.Forms | Out-Null
# エラー表示
if ($errorMessage -ne "") {
    [System.Windows.Forms.MessageBox]::Show( `
            "「$errorMessage」 は`r`nアクセスできません", `
            "GFモニタリング！")
}
#結果表示
if ($resultMessage -ne "") {
    [void][System.Windows.Forms.MessageBox]::Show($resultMessage, "GFモニタリング！")
}
exit
