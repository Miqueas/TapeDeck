#!/usr/bin/env -S nim --hints:off
import std/[
  strformat,
  strutils,
  parsecfg,
  streams
]

proc e(n: varargs[int]): string =
  return '\e' & '[' & join(n, ";") & 'm'

proc checkCommand(cmd: string, fallbackCmd = ""): tuple[exists: bool, cmd: string] =
  if findExe(cmd) != "":
    return (exists: true, cmd: cmd)
  elif findExe(fallbackCmd) != "":
    return (exists: true, cmd: fallbackCmd)
  else:
    return (exists: false, cmd: "")

proc checkCDep(name: string): bool =
  let pkgconf = checkCommand("pkgconf", "pkg-config")

  if not pkgconf.exists:
    echo("ERROR: You don't have either 'pkgconf' or 'pkg-config' installed")
    echo("INFO: Install it before build Tape Deck")
    quit(1)
  
  let code = gorgeEx(fmt"{pkgconf} {name}").exitCode

  if code != 0:
    echo(fmt"ERROR: C dependency '{name}' not found")
    echo("INFO: You need to install it using your system package manager")
    quit(1)
  else:
    echo(fmt"INFO: Found C dependency '{name}'")
    return true

proc checkNimDep(name: string): tuple[installed: bool, path: string] =
  let pkg = gorgeEx(fmt"nimble path {name}")

  if pkg.exitCode != 0:
    echo(fmt"ERROR: Nimble package '{name}' not found")
    echo(fmt"INFO: Install it with: nimble install {name}")
    quit(1)
  else:
    echo(fmt"INFO: Found Nimble package '{name}' at {pkg.output}")
    return (installed: true, path: pkg.output)

# let
#   libadwaita = pkgconf("libadwaita-1")
#   libmpdclient = pkgconf("libmpdclient")
#   gintro_ver = gorgeEx("nimble dump gintro | grep -Pi version")
#   gintro_pth = gorgeEx("nimble path gintro")
#   mpdclient_ver = gorgeEx("nimble dump mpdclient | grep -Pi version")
#   mpdclient_pth = gorgeEx("nimble path mpdclient")

if not defined(SkipChecks):
  discard

if gintro_pth.exitCode != 0:
  echo("ERROR: Nimble package 'gintro' not found")
  echo("INFO: Install it with: nimble install gintro")
  quit(2)
else:
  echo(fmt"INFO: Found Nimble package 'gintro' {gintro_ver.output} at {gintro_pth.output}")

if mpdclient_pth.exitCode != 0:
  echo("ERROR: Nimble package 'mpdclient' not found")
  echo("INFO: Install it with: nimble install mpdclient")
  quit(3)
else:
  echo(fmt"INFO: Found Nimble package 'mpdclient' {mpdclient_ver.output} at {mpdclient_pth.output}")

if findExe("blueprint-compiler") == "":
  echo("ERROR: Blueprint compiler not found")
  echo("INFO: Install it from: https://gitlab.gnome.org/jwestman/blueprint-compiler/")
  quit(4)
else:
  echo("INFO: Found Blueprint compiler")
  echo("INFO: Compiling application UI...")
  exec("blueprint-compiler compile data/App.blp --output data/App.ui")
  echo("INFO: Done!")

if findExe("nimassets") == "":
  echo("ERROR: nimassets not found")
  echo("INFO: Install it with: nimble install nimassets")
  quit(5)
else:
  echo("INFO: Found nimassets")
  echo("INFO: Bundling application assets...")
  exec("nimassets -o:src/resources.nim -f:data/App.ui -f:data/style.css")
  echo("INFO: Done!")

echo("INFO: Building Tape Deck...")
exec("nim c --hints:off src/Main.nim")
echo("INFO: Done! Run it with: ./io.github.Miqueas.TapeDeck")