local lgi = require("lgi")
local Gtk = lgi.Gtk
local Gdk = lgi.Gdk
local GdkPixbuf = lgi.GdkPixbuf
local Cairo = lgi.cairo
local GLib = lgi.GLib
local GObject = lgi.GObject

local app = Gtk.Application()
local builder = Gtk.Builder()
builder:add_from_file("data/ui/MoonPlayer3.glade")

local ui = builder.objects

function ui.HeaderHomeBtn:on_clicked()
  ui.WindowStack:set_visible_child_name("MainView")

  if not ui.PopoverConfigBottomControlsCheck:get_active() then
    ui.HeaderStack:set_visible_child_name("HeaderControls")
  else ui.HeaderStack:set_visible_child_name("HeaderMainStackSwitcher") end

  if ui.HeaderHomeBtn:get_sensitive() then
    ui.HeaderHomeBtn:set_sensitive(false)
  else ui.HeaderHomeBtn:set_sensitive(true) end
end

function CoverEvent(...)
  ui.WindowStack:set_visible_child_name("FullView")
  ui.HeaderStack:set_visible_child_name("HeaderTitle")

  if ui.HeaderHomeBtn:get_sensitive() then
    ui.HeaderHomeBtn:set_sensitive(false)
  else ui.HeaderHomeBtn:set_sensitive(true) end
end

ui.HeaderCoverEventBox.on_button_press_event = CoverEvent
ui.MainControlsCoverEventBox.on_button_press_event = CoverEvent

function ui.HeaderConfigBtn:on_clicked()
  if ui.PopoverConfig:get_visible() then
    ui.PopoverConfig:popdown()
  else ui.PopoverConfig:popup() end
end

--ui.MainControlsStack:set_visible_child_name("Blank")

function ui.PopoverConfigBottomControlsCheck:on_toggled()
  local hp = ui.HeaderStack:get_visible_child_name()
  local wp = ui.WindowStack:get_visible_child_name()
  local mcs = ui.MainControlsStack:get_visible_child_name()

  if wp == "MainView" then
    if hp == "HeaderControls" then
      ui.HeaderStack:set_visible_child_name("HeaderMainStackSwitcher")
    else ui.HeaderStack:set_visible_child_name("HeaderControls") end
  end

  if mcs == "MainStack" then ui.MainControlsStack:set_visible_child_name("MainControls")
  else ui.MainControlsStack:set_visible_child_name("MainStack") end
end

local HeaderCoverPixbuf = GdkPixbuf.Pixbuf.new_from_file("data/img/potsu_cover48.png")
local HeaderHeight = ui.Header:get_preferred_height()
local HeaderCoverImgScaled = HeaderCoverPixbuf:scale_simple(HeaderHeight, HeaderHeight, GdkPixbuf.InterpType.BILINEAR)
ui.HeaderCoverImg:set_from_pixbuf(HeaderCoverImgScaled)

function app:on_activate()
  ui.Window:present()
  self:add_window(ui.Window)
end

app:run()
