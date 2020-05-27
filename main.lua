require("libs/utils")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local app = Gtk.Application()
local builder = Gtk.Builder()
local conf = require("libs/conf") -- Librería para gestión de configuraciones
local _ = require("libs/text"):new("es") -- Librería para gestión de traducciones
conf:open() -- Abre la configuración de MoonPlayer

_:load("en", "i18n/en.lua")
_:load("es", "i18n/es.lua")
_:switch(conf._.lang)

log(builder:add_from_file("MoonPlayer.ui"), 'err', _("ui_load_err"))

local ui = builder.objects

ui.winViewStack:set_visible_child_name(conf._.active_view)
ui.winInfoViewText.label = _("app_name")
ui.aboutHeader.title = _("ui_about_title")
ui.about.comments = _("ui_about_comments")
ui.menuVolLabel.label = _("ui_menu_vol_label")
ui.menuBtnConfig.label = _("ui_menu_btn_config_label")
ui.menuBtnAbout.label = _("ui_menu_btn_about_label")
ui.configHeader.title = _("ui_config_title")
ui.configLabelLibrary.label = _("ui_label_library_chooser")
ui.configLabelLanguage.label = _("ui_label_language_chooser")

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