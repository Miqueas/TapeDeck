lgi       = require("lgi")
Gtk       = lgi.require("Gtk", "3.0")
Gio       = lgi.require("Gio", "2.0")
Hdy       = lgi.require("Handy", "1")
GObject   = lgi.require("GObject", "2.0")
GdkPixbuf = lgi.require("GdkPixbuf", "2.0")

-- Load the GResource file
local Res = Gio.Resource.load("Data/Resources.gresource")
Gio.resources_register(Res)

-- Sets the application main namespace and its classes
Moonplayer = lgi.package("Moonplayer")

-- Loads the rest of the app
require("Source.App")
require("Source.Controls")
require("Source.Header")
require("Source.Info")
require("Source.Window")

local App = Moonplayer.App()
App:register()

return App:run(arg)