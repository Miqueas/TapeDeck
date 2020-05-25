require("libs/log")
local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local Gst = lgi.require("Gst", "1.0")
local app = Gtk.Application()
local builder  = Gtk.Builder()

log(builder:add_from_file("LPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function app:on_activate()
  log(nil, "info", "Testing")
end

app:run()