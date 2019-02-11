@echo off
echo "ps1ファイルを実行します"
pushd %~dp0
powershell -NoProfile -ExecutionPolicy Unrestricted "./check-dirs.ps1"
pause > nul
exit