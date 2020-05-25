require("libs/log")
local lgi = require("lgi")
local fs  = require("lfs")
local Gtk = lgi.require("Gtk", "3.0")
local Gst = lgi.require("Gst", "1.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

log(builder:add_from_file("MoonPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function ui.winBtnConfig:on_clicked()
  ui.menu:show()
end

function ui.menuBtnConfig:on_clicked()
  ui.config:show()
  ui.config:run()
  ui.config:hide()
end

function ui.menuBtnAbout:on_clicked()
  ui.about:show()
  ui.about:run()
  ui.about:hide()
end

function app:on_activate()
  ui.win:show_all()
  self:add_window(ui.win)
end

app:run()