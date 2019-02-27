# �����t�H���_���w��ł���݌v�ɂȂ��Ă��܂�(�z��)�B
$FoldersConfigPath = ".\config\folders-settings.cfg"
$ExtensionsConfigPath = ".\config\extensions-settings.cfg"
$DIRS = (Get-Content $FoldersConfigPath) -as [string[]]
$EXTS = (Get-Content $ExtensionsConfigPath) -as [string[]]
$errorMessage = ""
$obj = @() 
foreach ($DIR in $DIRS) {
    if (Test-Path $DIR) {
        $finderPath = ("FileSystem::$DIR") # dir $DIR/hoge.xlsx �ɂ���΁Ahogxlsx�t�@�C�������ɍi��܂�
        Write-Output "<$finderPath>"
        $Files = (Get-ChildItem $finderPath -File -Depth 0 -Name) -as [string[]]
        $Folders = ( Get-ChildItem $finderPath -Directory -Depth 0 ) -as [string[]]
        $hashs = @()
        foreach ($item in $Files) {
            $hashs+=@{index=$hash.Count;item=$item;make= 1;delete= 2;none=false}
        }
        $obj += @{index = $obj.Count; path = $DIR; Files = $hashs; Folders = $Folders }
        # $obj | Add-Member $obj1 -Name $DIR -MemberType NoteProperty
    }
    else {
        # �t�H���_�̑��݊m�F
        if ($errorMessage -eq "") {
            $errorMessage += $DIR
        }
        else {
            $errorMessage += ",`r`n" + $DIR
        }
    }
}
# �A�Z���u���̓ǂݍ���
Add-Type -Assembly System.Windows.Forms
# �G���[�\��
if ($errorMessage -ne "") {
    [System.Windows.Forms.MessageBox]::Show( `
            "�u$errorMesge�v ��`r`n�A�N�Z�X�ł��܂���", `
            "GF���j�^�����O�I")
}
Remove-Item .\log\oldlog.json -Force
Rename-Item -NewName oldlog.json -LiteralPath .\log\newlog.json -Force
$obj | ConvertTo-Json -Depth 5 | Out-File .\log\newlog.json -Encoding default

# $newlog = Get-Content .\log\newlog.json -Encoding Default -Raw | ConvertFrom-Json
# $oldlog = Get-Content .\log\oldlog.json -Encoding Default -Raw | ConvertFrom-Json

# foreach ($item in $oldlog) {
#     Write-Output $item
# }