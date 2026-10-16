<!-- v2.2: fixes pause/Options bands and vertical background compression at 16:10; tested at 1920x1200 fullscreen. -->
# Well Dweller – Adaptive Aspect Patch

Ultrawide / adaptive-aspect patch for **Well Dweller** (Windows Steam build v.9.30.2026).
**Version 2.2 candidate – experimental, not an official game update.**

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
- Fixes narrow-room centring and opening cutscene dialogue placement
- Sorts the in-game resolution list (3440x1440 now sits between 2560x1600 and 3840x2160) with every entry matched to its real size
- Does **not** unlock the frame rate

## Safety and transparency
- The patcher modifies `WellDweller.exe` in place, after verifying its SHA256 matches the one supported Steam build and making a `WellDweller.exe.original` backup. Unsupported builds are refused.
- No network access, downloads or game assets are included; the scripts are plain text you can read.
- Because it is an unsigned script that edits an executable, antivirus software may warn about it. Verify files against `SHA256SUMS.txt` before running.
- Not affiliated with the game's developer or publisher.

## Testing status
Tested on the Steam build v.9.30.2026 by driving the running game and reading screenshots (menus, gameplay HUD, pause and options screens).

| Check | Result |
|---|---|
| 3440x1440 (21:9) HUD, lighting, pause darkening | Verified in v2.0 on a 3440x1440 display |
| 1920x1080 (16:9) gameplay and pause darkening | Verified in v2.0 |
| **v2.1** resolution list is sorted; each entry applies the size it is labelled with | Verified in game (every swapped entry, plus 3840x2160 and 4096x2160 by position) |
| **v2.1** saved-resolution restore on launch (21:9 and 2560x1600) | Verified in game (select, leave Options, exit, relaunch) |
| v2.1 on a native 3440x1440 monitor | Verified in the prior session; v2.2 visual regression pending |
| 1920x1200 (16:10) pause and Options | Verified in v2.2: full-height darkening; paused scene keeps gameplay proportions |
| Dialogue, cutscenes, mouse selection | Not yet tested |

**16:10:** pause and Options fixes verified at 1920x1200 fullscreen. 2560x1600, Steam Deck v2.2, and narrower ratios still need confirmation.

## Linux / Steam Deck (experimental)
`WellDweller_Patch_Linux.sh` applies the same patch under Proton. Put it in the game folder (`~/.local/share/Steam/steamapps/common/Well Dweller`) and run `bash WellDweller_Patch_Linux.sh` from Desktop mode. It was verified to produce the identical patched exe (same SHA256) as the Windows installer, The user confirmed v2.1 runs on Steam Deck; the new v2.2 16:10 fixes still need Deck confirmation.

## Known quirks
- **The game saves the last resolution you applied** (the patch doesn't change this). If it ends up at the wrong size, close the game and run `Set_Resolution.cmd`: it sets the saved resolution to your display's native size, backs up `Settings.sav` first, and refuses to run while the game is open. For a specific size: `Set_Resolution.cmd 1920 1080`. It is optional and separate from the patch, so it is not covered by `SHA256SUMS.txt`. Note: the game stores its 3440x1440 entry as `2560x1440` in `Settings.sav`; the helper writes that for you.
- Steam may show a *Cloud Conflict* prompt after Settings.sav is edited outside the game; pick whichever copy you want to keep.
- The patch relabels the game's 2560x1440 entry as 3440x1440, so a 2560x1440 (16:9) monitor has no native entry.
If you test another resolution, please [open an issue](../../issues) with the resolution, what you checked (HUD edges, lighting, dialogue, artwork, mouse selection) and screenshots.

## License
[MIT](LICENSE)
