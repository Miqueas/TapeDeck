require("libs/log")
local lgi = require("lgi")
local fs  = require("lfs")
local Gtk = lgi.require("Gtk", "3.0")
local Gst = lgi.require("Gst", "1.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

log(builder:add_from_file("MoonPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function ui.menu_preferences:on_clicked()
  ui.config:run()
  ui.config:hide()
end

function ui.menu_about:on_clicked()
  ui.about:run()
  ui.about:hide()
end

function ui.winBtnVol:on_clicked()
  ui.volumeCtrl:show()
end

function app:on_activate()
  ui.win:show_all()
  self:add_window(ui.win)
end

app:run()
