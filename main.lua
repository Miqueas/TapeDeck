require("libs/utils")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

local conf = require("libs/conf")
conf:open()

log(builder:add_from_file("MoonPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function ui.winBtnConfig:on_clicked()
  ui.menu:show()
end

function ui.menuBtnConfig:on_clicked()
  ui.config:run()
  ui.config:hide()
end

function ui.menuBtnAbout:on_clicked()
  ui.about:run()
  ui.about:hide()
end

function app:on_activate()
  ui.win:show_all()
  self:add_window(ui.win)
end

app:run()