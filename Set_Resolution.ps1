# Well Dweller - set the saved resolution while the game is closed.
# Usage: Set_Resolution.ps1                 -> native size of the primary display
#        Set_Resolution.ps1 -Width 1920 -Height 1080
# Optional: -Path <Settings.sav> (for testing).
param(
    [int]$Width = 0,
    [int]$Height = 0,
    [string]$Path = (Join-Path $env:LOCALAPPDATA 'WellDweller\Settings.sav')
)
$ErrorActionPreference = 'Stop'
try {
    if (Get-Process -Name WellDweller -ErrorAction SilentlyContinue) {
        throw 'Close Well Dweller first. Nothing changed.'
    }
    if (-not (Test-Path -LiteralPath $Path)) { throw "Settings file not found: $Path" }
    if ($Width -le 0 -or $Height -le 0) {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -TypeDefinition 'using System.Runtime.InteropServices; public class WDDpi { [DllImport("user32.dll")] public static extern bool SetProcessDPIAware(); }'
        [void][WDDpi]::SetProcessDPIAware()
        $b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $Width = $b.Width; $Height = $b.Height
    }
    if ($Width -lt 640 -or $Height -lt 480 -or $Width -gt 16384 -or $Height -gt 16384) {
        throw "Unreasonable size ${Width}x${Height}. Nothing changed."
    }
    $text = [System.IO.File]::ReadAllText($Path)
    $rw = [regex]'"res_width":\s*[\d.]+'
    $rh = [regex]'"res_height":\s*[\d.]+'
    if ($rw.Matches($text).Count -ne 1 -or $rh.Matches($text).Count -ne 1) {
        throw 'Unexpected settings format (res_width/res_height not found exactly once). Nothing changed.'
    }
    $new = $rw.Replace($text, ('"res_width":{0}.0' -f $Width))
    $new = $rh.Replace($new, ('"res_height":{0}.0' -f $Height))
    if ($new -eq $text) { Write-Host "Already ${Width}x${Height}."; exit 0 }
    Copy-Item -LiteralPath $Path -Destination ($Path + '.bak-before-res-change') -Force
    [System.IO.File]::WriteAllText($Path, $new, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Saved resolution set to ${Width}x${Height}. Backup: $Path.bak-before-res-change"
    exit 0
} catch {
    Write-Host ('ERROR: ' + $_.Exception.Message)
    exit 1
}
