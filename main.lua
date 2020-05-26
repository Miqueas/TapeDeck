require("libs/utils")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

local conf = require("libs/conf")
conf:load()

for k, v in pairs(conf._) do print(k, v) end

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