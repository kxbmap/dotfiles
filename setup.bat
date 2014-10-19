@echo off
powershell -ExecutionPolicy RemoteSigned -NoProfile -File %~dp0setup.ps1
pause
