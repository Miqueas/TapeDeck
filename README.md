[![License][LicenseBadge]][LicenseURL]
![Github Actions status, Windows][WinBuildBadge]
![Github Actions status, Flatpak][FlatpakBuildBadge]

# Tape Deck (WIP)

MPD client, done right.

## Building

You'll need:

 * `meson >=0.56.0`
 * `libadwaita-1 >=1.0`
 * `libmpdclient >=2.19`

Then:

```
git clone https://github.com/Miqueas/TapeDeck.git
cd TapeDeck
meson _BUILD
ninja -C _BUILD
```

[LicenseBadge]: https://img.shields.io/github/license/Miqueas/TapeDeck?label=License
[LicenseURL]: https://opensource.org/licenses/Zlib
[WinBuildBadge]: https://img.shields.io/github/actions/workflow/status/Miqueas/TapeDeck/windows.yml?label=Build&logo=windows
[FlatpakBuildBadge]: https://img.shields.io/github/actions/workflow/status/Miqueas/TapeDeck/flatpak.yml?label=Build&logo=linux&logoColor=white