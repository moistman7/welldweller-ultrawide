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
Tested on the Steam build v.9.30.2026 with screenshots at each resolution (main menu, gameplay HUD, pause and options screens).

| Output | Result |
|---|---|
| 3440x1440 (21:9) | Verified: menu, HUD edges, lighting and pause darkening all fill the frame |
| 1920x1080 (16:9) | Verified: gameplay and pause darkening correct (pillarboxed to the 2560x1440 logical canvas) |
| 1920x1200, 2560x1600 (16:10) | **Known issue:** gameplay looks correct, but the pause darkening does not reach the top and bottom edges, leaving lighter bands |
| Dialogue, nest scene, mouse selection, switching resolution from the main menu | Not yet tested |

**Supported:** 16:9 and wider. **Not supported yet:** narrower than 16:9 (for example 16:10). Fixing it needs a change to the patched executable code; it is planned for a later version.

## Known quirks
- **Resolution is saved by the game, not the patch.** If you switch resolution in Options and then quit, the game keeps that choice. To return to your native size, set it again in Options > Graphics > Resolution, or edit `res_width` / `res_height` in `%LOCALAPPDATA%\WellDweller\Settings.sav` while the game is closed (back up the file first).
- The Resolution row steps through the modes your display offers in an order that is not sorted by size, so check the value shown before pressing Enter to apply it.

If you test another resolution, please [open an issue](../../issues) with the resolution, what you checked (HUD edges, lighting, dialogue, artwork, mouse selection) and screenshots.

## License
[MIT](LICENSE)
