-- GI Wrapper
local lgi  = require("lgi")

-- Just testing the LGI logging tool/system
Log = lgi.log.domain("Moonplayer")
Log.message("Loaded LGI")

-- Base libs
Gio        = lgi.require("Gio", "2.0")
GLib       = lgi.require("GLib", "2.0")
GObject    = lgi.require("GObject", "2.0")
Log.message("Loaded GLib, Gio and GObject")

-- Basic graphics (images) support
GdkPixbuf  = lgi.require("GdkPixbuf", "2.0")
Log.message("Loaded GdkPixbuf")

-- GUI (Gtk and LibHandy)
Gtk        = lgi.require("Gtk", "3.0")
Hdy        = lgi.require("Handy", "1")
Log.message("Loaded Gtk and libhandy")

-- GStreamer (Multimedia)
Gst        = lgi.require("Gst", "1.0")
GstPbutils = lgi.require("GstPbutils", "1.0")
Log.message("Loaded GStreamer")

-- Load the GResource file
local Res = Gio.Resource.load("Data/Resources.gresource")
Gio.resources_register(Res)
Log.message("Loaded and registered the GResource")

-- Sets the application main namespace and its classes
Moonplayer = lgi.package("Moonplayer")
Log.message("Created the Moonplayer namespace")

-- I'm using this in development
local Settings = Gtk.Settings.get_default()
Settings.gtk_application_prefer_dark_theme = true
Settings.gtk_theme_name = "Adwaita"
Log.message("Configured the app theme")

-- Loads the rest of the app
require("Source.App")
require("Source.Player")
require("Source.Window")
require("Source.Header")
require("Source.Info")
require("Source.Controls")
require("Source.LocalItem")
require("Source.LibraryView")
Log.message("Loaded source files")

local App = Moonplayer.App()
App:register()
Log.message("Created and registered the app instance")

local status = App:run(arg)
Log.message("App ended")

return status