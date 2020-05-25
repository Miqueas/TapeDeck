require("libs/log")
local lgi = require("lgi")
local fs  = require("lfs")
local Gtk = lgi.require("Gtk", "3.0")
local Gst = lgi.require("Gst", "1.0")
local app = Gtk.Application()
local builder = Gtk.Builder()

log(builder:add_from_file("MoonPlayer.ui"), 'err', "Hubo un error al cargar la interfaz.")

local ui = builder.objects

function app:on_startup( ... )
  log(nil, 'info', "Iniciando interfaz")
end

function app:on_activate()
  log(nil, 'info', "Interfaz inicializada")

  function ui.appBtnConfig:on_clicked()
    ui.aboutDialog:show()
  end

  ui.appWindow:show_all()
  self:add_window(ui.appWindow)
end

function app:on_window_added()
  log(nil, 'info', "Añadida ventana principal")
end

function app:on_shutdown()
  log(nil, 'info', "Destruida la interfaz")
  log(nil, 'info', "Finalizada la sesión")
end

app:run()
