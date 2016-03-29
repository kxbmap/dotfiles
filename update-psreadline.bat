@echo off

tasklist /FI "IMAGENAME eq powershell.exe" 2>NUL | find /I /N "powershell.exe"
if "%ERRORLEVEL%"=="0" goto ERR

powershell -NoProfile -Command "Update-Module PSReadline"
goto END

:ERR
echo Error: PowerShell is running

:END
pause
