# What is this?

MoonPlayer is a very simple music player written in pure Lua. It's uses GTK for the UI and Gstreamer for media playback.

# Running

__MoonPlayer is still not finished and is a WIP (Work In Progress) that currently can't
play music__, but you can run the `main.lua` for preview the app. You will need:

 * Lua (5.3, but 5.1 or 5.2 should work)
 * [lgi](https://github.com/pavouk/lgi/)
 * [dkjson](http://dkolf.de/src/dkjson-lua.fsl/home)
 * [luafilesystem](https://keplerproject.github.io/luafilesystem/index.html)

Also you can install all dependencies using LuaRocks:

```
luarocks install lgi
luarocks install dkjson
luarocks install luafilesystem
```