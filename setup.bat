@echo off

pushd
cd /d %~dp0

rem Run setup script
powershell -ExecutionPolicy RemoteSigned -NoProfile -File %~dp0setup.ps1

popd
pause
