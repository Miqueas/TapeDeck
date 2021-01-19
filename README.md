# What is this?

A GTK music player written in pure Lua.

# Running

__MoonPlayer is still not finished and currently can't play music__, but still, you can run `Main.lua` for a preview of the app. You will need:

 * Lua 5.1+ (LuaJIT also works)
 * [lgi](https://github.com/pavouk/lgi/)

You can install lgi using LuaRocks:

```
luarocks install lgi
```

Or with the package manager of your distro (if available).

Before running Moonplayer, you'll need compile the `Data/Resources.xml` file:

```
glib-compile-resources Data/Resources.xml
```

And finally you can run the app:

```
lua Main.lua
```
