# Development notes

How the patch is structured, for anyone extending it. Addresses are virtual addresses in the original Steam exe (v.9.30.2026, SHA256 in `WellDweller_Ultrawide_Patch.ps1`).

## Approach
- `WellDweller_Ultrawide_Patch.ps1` verifies the original exe hash, applies byte patches at file offsets, appends a tail section, and keeps `WellDweller.exe.original`.
- The game is GameMaker YYC. The resolution options are index-keyed tables, so four places must always change together:

| Purpose | Address |
|---|---|
| Label list builders | 1402F2D60, 1402F4130 |
| Starting-index compares | 1402F2427 |
| Apply ladder (index to size) | 1402EC0C0 |
| Saved-size reverse lookup returns | 1424BBA33, 1424BBA53 |

Reordering labels without the other three desynchronises the menu text from the applied size.

## Behaviour to know
- `Settings.sav` is JSON with `res_width` / `res_height`. The 21:9 entry is stored as 2560x1440 and is written when leaving Options.
- Editing `Settings.sav` outside the game triggers a Steam Cloud conflict prompt.
- Native 3440x1440 was verified on a 3440x1440 display (Graphics menu shows 3440x1440, full width).

## 16:10 fixes / v2.2 candidate
- v2.2 expands full-screen darkening vertically and preserves paused-background proportions. Verified at 1920x1200 fullscreen; main-menu light beam remains outside this fix.

## Testing
Launch via `steam://rungameid/3699590`, send scancode `keybd_event` input, capture the client area. Static analysis was done with an Iced (.NET) disassembler.

## Linux / Steam Deck
`WellDweller_Patch_Linux.sh` applies the same patch table and appended section as the PowerShell installer (generated from it) using only bash, dd, base64 and sha256sum. It was tested against the original exe and produces the identical v2.1 hash. Run it from the game folder, or pass the folder as an argument. Under Proton the game folder is usually `~/.local/share/Steam/steamapps/common/Well Dweller`.

Vertical delta = (max(1440,2560*h/w)-1440)/2. Cave 144791200 stores delta as float at 144793068. Rectangle matched-path hook 144790224 ->144791300 expands top/bottom. Sprite hook 144790634 ->144791900 adjusts cave-entry [rsp+28h] Y and [rsp+38h] Yscale; CALL return address must be included. 16:10 delta=80; Yscale multiplier=1+delta/720. Constants720f/1f at144793070/74. All new bytes are in .uwfix. Baseline and candidate tests used a temporary P pause binding, restored afterward.
