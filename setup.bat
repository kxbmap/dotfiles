@echo off
pwsh -ExecutionPolicy RemoteSigned -NoProfile -File %~dp0setup.ps1
pause
