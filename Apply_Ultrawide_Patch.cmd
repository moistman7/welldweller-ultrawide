@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0WellDweller_Ultrawide_Patch.ps1" > "%~dp0patch_log.txt" 2>&1 < nul
set "patch_result=%errorlevel%"
type "%~dp0patch_log.txt"
echo.
pause
exit /b %patch_result%
