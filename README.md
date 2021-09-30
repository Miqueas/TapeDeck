[![License][LicenseBadge]][licenseURL]

# Tape Deck (WIP)

A modern, cross-platform music player, with MPD support, written in Vala

## Building

You'll need:

 * `meson >=0.56.0`
 * `gtk4 >=4.4`
 * `libadwaita-1 >=1.0`

Then:

```
git clone https://github.com/Miqueas/TapeDeck.git
cd TapeDeck
meson . _BUILD
ninja -C _BUILD
```

[LicenseBadge]: https://img.shields.io/badge/License-Zlib-brightgreen?style=flat
[LicenseURL]: https://opensource.org/licenses/Zlib