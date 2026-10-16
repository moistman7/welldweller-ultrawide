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

## Known issue / v2.2 candidate
- At 16:10 and narrower, the pause-darkening overlay is sized for 1440 logical height and leaves a gap; the main-menu light beam is also cut off at the top.

## Testing
Launch via `steam://rungameid/3699590`, send scancode `keybd_event` input, capture the client area. Static analysis was done with an Iced (.NET) disassembler.
