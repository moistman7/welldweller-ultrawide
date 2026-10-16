@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0WellDweller_Ultrawide_Restore.ps1"
set "restore_result=%errorlevel%"
echo.
pause
exit /b %restore_result%
