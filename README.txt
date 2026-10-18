WELL DWELLER - ADAPTIVE ASPECT PATCH
Version 2.2.1 candidate | Windows Steam build v.9.30.2026

INSTALL
1. Close Well Dweller.
2. In Steam, right-click Well Dweller > Manage > Browse local files.
3. Extract the ZIP, then copy the four .cmd/.ps1 files beside
   WellDweller.exe. Do not run the installer from inside the ZIP.
4. Double-click Apply_Ultrawide_Patch.cmd.
5. Confirm the window reports "Patched OK". patch_log.txt also records
   the result. Launch the game normally through Steam.

The installer verifies the exact executable before changing anything,
creates WellDweller.exe.original, and checks the patched result.
Unsupported game builds are refused. Do not rename/delete the backup.
If the folder is not writable, allow your account write access or run the
launcher as administrator. No downloads or network access are required.

WHAT IT DOES
- Adapts camera width and HUD edge positions to the active render size.
- Preserves menu/story proportions and captured Options backgrounds.
- Extends lighting/darkening effects across the wider view.
- Corrects narrow-room centring and opening cutscene dialogue placement.
- Keeps the camera steady in cutscenes when speakers change.
- Lists the resolutions in ascending order (3440x1440 now sits between 2560x1600
  and 3840x2160) and keeps every entry matched to its real size.

Change resolution in-game without reapplying the patch. It uses the
render dimensions the game provides; it does not add every display mode
to the game's resolution list. The existing 3440x1440 entry is retained.

LINUX / STEAM DECK (EXPERIMENTAL)
Copy WellDweller_Patch_Linux.sh into the game folder (Desktop mode,
~/.local/share/Steam/steamapps/common/Well Dweller), open a terminal there and run:
  bash WellDweller_Patch_Linux.sh
It produces the identical patched exe as the Windows installer (same hash
checks and WellDweller.exe.original backup). To undo, copy the backup over
WellDweller.exe or use Steam's Verify integrity of game files. 16:10 screens
(such as the Deck) still have the pause-darkening known issue.

RESTORE
Close the game and double-click Restore_Original.cmd. This restores the
verified backup. Steam's Verify integrity of game files can also restore
the original executable. After a Steam update, do not force this patch
onto a changed executable; wait for a compatible patch build.

STATUS / LIMITATIONS
This is an experimental candidate, not an official game update.
The earlier fixed 3440x1440 patch received player visual confirmation.
V2 automatic switching has passed instruction-emulation and installer
checks. V2.2 pause and Options were verified at 1920x1200 fullscreen:
no bright bands and no vertical compression. Other aspect-ratio visual
regression checks and Deck v2.2 confirmation remain pending.
Test resolution switches in both menus and gameplay. Check HUD edges,
lighting, dialogue, artwork proportions and mouse selection.

16:9 and wider outputs use a logical height of 1440 and aspect-derived
width. At 16:10 the canvas is taller; v2.2 adapts pause darkening and
background height to it. Mouse alignment and ratios narrower than 16:10
remain unverified. Effect canvases cover
logical widths up to 16384. The larger buffers use about 22.5 MiB for
four RGBA surfaces before driver overhead.

THE FRAME RATE IS NOT UNLOCKED. Gameplay timing is frame-based; this
package preserves the original frame rate.

COMPATIBILITY
Only the exact supported Steam executable (71,230,976 original bytes):
SHA256 dabebd9145ad005b2fde2d06d8c018fc58520f156900ad48f4a8dea6aa625cc2
Accepts original or known previous patch builds v1 through v2.1.
No game executable, assets, saves or personal files are included.
This patch is not affiliated with the game's developer or publisher.
