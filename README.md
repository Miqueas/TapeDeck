# Tape Deck (WIP)

GTK MPD client

## Building

You'll need:

 * `meson >=0.56.0`
 * `libadwaita-1 >=1.0`
 * `libmpdclient >=2.19`

Install them on your systyem using you preferred method. If you use Arch Linux, you can simply do:

```bash
pacman -S libmpdclient libadwaita
```

Then:

```
git clone https://github.com/Miqueas/TapeDeck.git
cd TapeDeck
meson setup _BUILD .
ninja -C _BUILD
```