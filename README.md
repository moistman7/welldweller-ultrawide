# Well Dweller – Adaptive Aspect Patch

Ultrawide / adaptive-aspect patch for **Well Dweller** (Windows Steam build v.9.30.2026).
**Version 2.0 candidate – experimental, not an official game update.**

**[Download the latest release](../../releases/latest)**

## Install
1. Close Well Dweller.
2. In Steam: right-click Well Dweller > Manage > Browse local files.
3. Extract the release ZIP and copy the four `.cmd`/`.ps1` files beside `WellDweller.exe`. Don't run the installer from inside the ZIP.
4. Double-click `Apply_Ultrawide_Patch.cmd` and confirm it reports "Patched OK".

To undo: run `Restore_Original.cmd`, or use Steam's *Verify integrity of game files*.
Full details are in [README.txt](README.txt) and [CHANGELOG.txt](CHANGELOG.txt).

## What it does
- Adapts camera width and HUD edges to the active render size
- Extends lighting/darkening effects across the wider view
- Fixes narrow-room centring and nest dialogue placement
- Does **not** unlock the frame rate

## Safety and transparency
- The patcher modifies `WellDweller.exe` in place, after verifying its SHA256 matches the one supported Steam build and making a `WellDweller.exe.original` backup. Unsupported builds are refused.
- No network access, downloads or game assets are included; the scripts are plain text you can read.
- Because it is an unsigned script that edits an executable, antivirus software may warn about it. Verify files against `SHA256SUMS.txt` before running.
- Not affiliated with the game's developer or publisher.

## Testing status
| Check | Status |
|---|---|
| Fixed 3440x1440 patch (earlier version) | Visually confirmed by a player |
| V2 automatic switching: instruction emulation, install/upgrade/restore tests | Passed |
| V2 native visual testing across resolutions | **Pending** |

Narrower-than-16:9 outputs are unverified. If you test another resolution, please
[open an issue](../../issues) with your resolution, what you checked (HUD edges, lighting,
dialogue, artwork, mouse selection) and screenshots.

## License
[MIT](LICENSE)
