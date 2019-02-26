$newlog = Get-Content .\newlog.json -Encoding Default -Raw | ConvertFrom-Json
$oldlog = Get-Content .\oldlog.json -Encoding Default -Raw | ConvertFrom-Json

Write-Host $newlog.GetType()
foreach ($item in $newlog[0][0]) {
    Write-Host $item.GetType()
}