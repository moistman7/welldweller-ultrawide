$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $dir 'WellDweller.exe'
$bak = Join-Path $dir 'WellDweller.exe.original'
$want = 'dabebd9145ad005b2fde2d06d8c018fc58520f156900ad48f4a8dea6aa625cc2'
$known = @($want, '2e96d2a0b9dc1b2fab5905ee361648ad31acf0dc29fcfcffc0df107f8d029ec8', '353de2d97a41310b72cea4f9ffb4902a7f2a14f4f48b33695d331969fba72203', '8aa7b24eac0264046c021c6f8ba4eecda09f8f28d4796e163ace7bb367b714f1', '1ed1770e9367d9531f610b8b4362f6ba41d1092a9724732f3fcd07d76b9e9962', '15fd08b4ef83405cf40ffd7260ca98d7e9b4eb20171bf8c5de54aa8a63e6e5d9', 'c6551797206f27e9ac35372fd9dd70cffb3953003479f3030e20301b45577789', '4953ceb3af1c9f6f0222807f1506a608dcb7d6f2f7efc544f702ee9f959f4051', '9b4f81dfe8fa704e23610f9061bfd62356717d3b357fe3afda03dd620e14a655', 'e9835f181d89bc077125fa087a2e2a0ad06bc31273336c1887d3016c92d1d27f', 'd60a66cb5fb7f0ecd0e4a2750437eb90a16eb2c64a2427fc63cf500b821568f6', '3dd8997e8e6c7d6067473c09f25a5b47f7659f728cc0252fcc47c4b2a60bd3ff', 'a6d917d2074ab9538609d3187f21bb494b1ed96fba9cbcb386a7434ac02ca0fc')
function Get-Sha($p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash.ToLowerInvariant() }
$temp = $null
try {
    if ((Get-Sha $bak) -ne $want) { throw 'Original backup hash mismatch. Nothing changed.' }
    $current = Get-Sha $exe
    if ($current -eq $want) { Write-Host 'Already original.'; exit 0 }
    if ($current -notin $known) { throw 'Executable is an unknown version. Restore cancelled to preserve it.' }
    $temp = Join-Path $dir ('WellDweller.restore.' + [Guid]::NewGuid().ToString('N') + '.tmp')
    Copy-Item -LiteralPath $bak -Destination $temp
    if ((Get-Sha $temp) -ne $want) { throw 'Restore copy verification failed. Executable unchanged.' }
    if ((Get-Sha $exe) -ne $current) { throw 'Executable changed during restore. Replacement cancelled.' }
    [System.IO.File]::Replace($temp, $exe, [System.Management.Automation.Language.NullString]::Value)
    $temp = $null
    if ((Get-Sha $exe) -ne $want) { throw 'Post-restore verification failed.' }
    Write-Host 'Original restored.'
    exit 0
} catch { Write-Host ('ERROR: ' + $_.Exception.Message); exit 1 }
finally { if ($temp -and (Test-Path -LiteralPath $temp)) { Remove-Item -LiteralPath $temp -Force } }
