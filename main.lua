require("libs/utils")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local app = Gtk.Application()
local builder = Gtk.Builder()
local conf = require("libs/conf") -- Librería para gestión de configuraciones
local _ = require("libs/text"):new("es") -- Librería para gestión de traducciones
conf:open() -- Abre la configuración de MoonPlayer

local dbg = not(strToBool(os.getenv("DEBUG")) or conf._.debug)

-- Carga las traducciones
_:load("en", "i18n/en.lua")
_:load("es", "i18n/es.lua")
log(dbg, 'info', "Traducciones cargadas")

-- Establece el idioma según la configuración
_:switch(conf._.lang)
log(dbg, 'info', "Indioma establecido a: \"%s\"", conf._.lang)

if dbg then log(builder:add_from_file("MoonPlayer.ui"), 'err', _("ui_load_err"))
else builder:add_from_file("MoonPlayer.ui") end
log(dbg, 'info', "Leida interfaz de usuario")

local ui = builder.objects

ui.winViewStack:set_visible_child_name(conf._.view)
ui.winInfoViewText.label = _("app_name")
ui.aboutHeader.title = _("ui_about_title")
ui.about.comments = _("ui_about_comments")
ui.menuVolLabel.label = _("ui_menu_vol_label")
ui.menuBtnConfig.text = _("ui_menu_btn_config_label")
ui.menuBtnAbout.text = _("ui_menu_btn_about_label")
ui.configHeader.title = _("ui_config_title")
ui.configLabelLibrary.label = _("ui_label_library_chooser")
ui.configLabelLanguage.label = _("ui_label_language_chooser")
ui.welcomeTitle.label = _("ui_welcome_title")
ui.welcome.text = _("ui_welcome_primary_text")
ui.welcome.secondary_text = _("ui_welcome_secondary_text")
ui.winViewPlaybackColArtist.title = _("ui_view_playback_col_artist")
ui.winViewPlaybackColTitle.title = _("ui_view_playback_col_title")
ui.winViewPlaybackColAlbum.title = _("ui_view_playback_col_album")
log(dbg, 'info', "Aplicadas traducciones")

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

function onChangeView(view)
  if view == "playback" then ui.winListBox:select_row(ui.winListBoxRowPlayback)
  elseif view == "library" then ui.winListBox:select_row(ui.winListBoxRowLibrary)
  elseif view == "playlists" then ui.winListBox:select_row(ui.winListBoxRowPlaylists)
  else print(("No row for '%s'"):format(view)) end
end

function ui.winListBox:on_row_activated(row, ...)
  if row == ui.winListBoxRowPlayback then
    ui.winViewStack:set_visible_child_name("playback")
  elseif row == ui.winListBoxRowLibrary then
    ui.winViewStack:set_visible_child_name("library")
  elseif row == ui.winListBoxRowPlaylists then
    ui.winViewStack:set_visible_child_name("playlists")
  else
    log(nil, 'warn', "No action for selected row!")
  end
end

function app:on_activate()
  onChangeView(conf._.view)
  ui.win:show_all()
  self:add_window(ui.win)
end
log(dbg, 'info', "Aplicación iniciada")

app:run()
log(dbg, 'info', "Finalizada la sesión")