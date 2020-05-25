require("libs/log")
local lgi = require("lgi")
local fs  = require("lfs")
local Gtk = lgi.require("Gtk", "3.0")
local Gst = lgi.require("Gst", "1.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

log(builder:add_from_file("MoonPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function ui.appBtnConfig:on_clicked()
  ui.configDialog:show()
  ui.configDialog:run()
  ui.configDialog:hide()
end

function ui.configDialogBtnAbout:on_clicked()
  ui.aboutDialog:show()
  ui.aboutDialog:run()
  ui.aboutDialog:hide()
end

function app:on_activate()
  ui.appWindow:show_all()
  self:add_window(ui.appWindow)
end

app:run()
