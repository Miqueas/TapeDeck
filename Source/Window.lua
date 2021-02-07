Moonplayer:class("Window", Hdy.ApplicationWindow)

function Moonplayer.Window:_class_init(Klass)
  Klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Window.ui")
  Klass:bind_template_child_full("LocalView", true, 0)

  function Klass:set_property(id, val, spec)
    if id == 1 then
      self.priv.LocalView = val:get_object()
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, spec)
    end
  end

  function Klass:get_property(id, val, spec)
    if id == 1 then
      val:set_object(self.priv.LocalView)
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, spec)
    end
  end

  Klass:install_property(1, GObject.ParamSpecObject(
      "LocalView", "Local View", "Local view widget",
      Moonplayer.LibraryView,
      {
        GObject.ObjectConstructParam.PARAM_STATIC_STRINGS,
        GObject.ParamFlags.READABLE,
        GObject.ParamFlags.PRIVATE
      }
    )
  )
end

function Moonplayer.Window:_init()
  self:init_template()

  self.priv.LocalView = self:get_template_child(Moonplayer.Window, "LocalView")

  local styles = Gtk.CssProvider();
  styles:load_from_resource("/com/github/M1que4s/Moonplayer/Data/Styles.css");

  self:get_style_context().add_provider_for_screen(
    self:get_screen(self),
    styles,
    Gtk.STYLE_PROVIDER_PRIORITY_USER
  )
end