Moonplayer:class("Window", Hdy.ApplicationWindow)

function Moonplayer.Window:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Window.ui")
  klass:bind_template_child_full("Stack", true, 0)
  klass:bind_template_child_full("Header", true, 0)
end

function Moonplayer.Window:_init()
  self:init_template()

  self.priv.Stack = self:get_template_child(Moonplayer.Window, "Stack")
  self.priv.Header = self:get_template_child(Moonplayer.Header, "Header")

  local styles = Gtk.CssProvider();
  styles:load_from_resource("/com/github/M1que4s/Moonplayer/Data/Styles.css");

  self:get_style_context().add_provider_for_screen(
    self:get_screen(self),
    styles,
    Gtk.STYLE_PROVIDER_PRIORITY_USER
  )
end