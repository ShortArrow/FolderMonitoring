# 配列
$arr = @()

# ユーザー定義オブジェクトを追加
$p = @{index=-1; name=""; age=-1}
$arr += New-Object PSObject -Property $p
$arr += New-Object PSObject -Property $p
$arr += New-Object PSObject -Property $p

$arr[0].index = 0
$arr[0].name  = "あいうえお"
$arr[0].age   = 30

$arr[1].index = 1
$arr[1].name  = "かきくけこ"
$arr[1].age   = 18

$arr[2].index = 2
$arr[2].name  = "さしすせそ"
$arr[2].age   = 99


# こっちの方がいいかも
# ただし、index が inde とかになっていてもエラーにはならない
<#
$arr += New-Object PSObject -Property @{index=0; name="あいうえお"; age=30}
$arr += New-Object PSObject -Property @{index=1; name="かきくけこ"; age=18}
$arr += New-Object PSObject -Property @{index=2; name="さしすせそ"; age=99}
#>

# 表示
$arr | ConvertTo-Json | Out-File .\log\arr.json -Encoding default