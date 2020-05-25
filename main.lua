local lgi = require("lgi")
local lfs = require("lfs")
local Gtk = lgi.require("Gtk", "3.0")
local app = Gtk.Application()
local ui = Gtk.Builder()

assert(ui:add_from_file("LPlayer.ui"), "Error al cargar la definición de interfaz")

local appWindow          = ui:get_object("appWindow")
local appStatusBar       = ui:get_object("appStatusBar")
local appBtnPlay         = ui:get_object("appBtnPlay")
local appBtnStop         = ui:get_object("appBtnStop")
local appBtnPrev         = ui:get_object("appBtnPrev")
local appBtnNext         = ui:get_object("appBtnNext")
local appBtnConfig       = ui:get_object("appBtnConfig")
local appContentPlaylist = ui:get_object("appContentPlaylist")
local appContentLibrary  = ui:get_object("appContentLibrary")

for k, v in lfs.dir(("%s/Música"):format(os.getenv("HOME"))) do
  print(k, v)
end

function btnHandler(self)
  local btn = self:get_name()

  if btn == "btnPlay" then
    appStatusBar:push(0, "Playing!")
  elseif btn == "btnStop" then
    appStatusBar:push(0, "Stoped.")
  elseif btn == "btnPrev" then
    appStatusBar:push(0, "Playing previous item...")
  elseif btn == "btnNext" then
    appStatusBar:push(0, "Playing next item...")
  elseif btn == "btnConfig" then
    appStatusBar:push(0, "Configuration dialog opened!")
  else
    appStatusBar:push(0, "Unknown signal!")
  end
end

appBtnConfig.on_clicked = btnHandler
appBtnPlay.on_clicked = btnHandler
appBtnStop.on_clicked = btnHandler
appBtnPrev.on_clicked = btnHandler
appBtnNext.on_clicked = btnHandler

function app:on_activate()
  appWindow:show_all()
  self:add_window(appWindow)
end

app:run()