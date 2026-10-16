@echo off
rem Sets the saved resolution to your display's native size. Close the game first.
rem For a specific size:  Set_Resolution.cmd 1920 1080
if "%~2"=="" (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set_Resolution.ps1"
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set_Resolution.ps1" -Width %1 -Height %2
)
pause
