function ffff {
    Invoke-Item $DIRS
}
$PSVersionTable.PSVersion.Major
# �����t�H���_���w��ł���݌v�ɂȂ��Ă��܂�(�z��)�B
$FoldersConfigPath = ".\config\folders-settings.cfg"
$ExtensionsConfigPath = ".\config\extensions-settings.cfg"
$DIRS = (Get-Content $FoldersConfigPath) -as [string[]]
$EXTS = (Get-Content $ExtensionsConfigPath) -as [string[]]
# ���C���̏���
$errorMessage = ""
$resultMessage = ""
foreach ($DIR in $DIRS) {
    if (Test-Path $DIR) {
        $finderPath = ("FileSystem::$DIR") # dir $DIR/hoge.xlsx �ɂ���΁Ahoge.xlsx�t�@�C�������ɍi��܂�
        Write-Output "[$finderPath]"
        $Folders = (Get-ChildItem $finderPath | ?{ $_.GetType().Name -eq "DirectoryInfo"}) -as [string[]]
        $Files = ( Get-ChildItem $finderPath | ?{ $_.GetType().Name -eq "FileInfo" }) -as [string[]]
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
            $textBuffer = "�u$DIR�v ��"
            if ($FolderCount -ne 0) {
                $textBuffer += "`r`n�t�H���_�� $FolderCount ��"
                if ($FileCount -ne 0) {
                    $textBuffer += "��"
                }
            }
            if ($FileCount -ne 0) {
                $textBuffer += "`r`n�t�@�C���� $FileCount ��"
            }
            $textBuffer += "����܂��B"
            if ($resultMessage -eq "") {
                . .\toast.ps1 $textBuffer "GF���j�^�����O�I" ffff
                $resultMessage += $textBuffer
            }
            else {
                $resultMessage += "`r`n" + $textBuffer
            }
        }
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
Add-Type -Assembly System.Windows.Forms | Out-Null
# �G���[�\��
if ($errorMessage -ne "") {
    [System.Windows.Forms.MessageBox]::Show( `
            "�u$errorMessage�v ��`r`n�A�N�Z�X�ł��܂���", `
            "GF���j�^�����O�I")
}
#���ʕ\��
if ($resultMessage -ne "") {
    # [void][System.Windows.Forms.MessageBox]::Show($resultMessage, "GF���j�^�����O�I")
    # . .\toast.ps1 $resultMessage "GF���j�^�����O�I" .\test.html
}
exit
