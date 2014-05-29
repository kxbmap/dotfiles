@echo off

pushd
cd /d %~dp0

rem Run setup script
powershell -Command if ((Get-ExecutionPolicy) -eq 'Restricted') { Set-ExecutionPolicy RemoteSigned }
powershell -File %~dp0setup.ps1

popd
pause
