Moonplayer:class("Header", Hdy.HeaderBar)

function Moonplayer.Header:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Header.ui")
  klass:bind_template_child_full("Stack", true, 0)
  klass:bind_template_child_full("HomeBtn", true, 0)
  klass:bind_template_child_full("Switcher", true, 0)
  klass:bind_template_child_full("HomeBtnRev", true, 0)
end

function Moonplayer.Header:_init(...)
  self:init_template()

  self.priv.Stack = self:get_template_child(Gtk.Stack, "Stack")
  self.priv.HomeBtn = self:get_template_child(Gtk.Button, "HomeBtn")
  self.priv.Switcher = self:get_template_child(Hdy.ViewSwitcher, "Switcher")
  self.priv.HomeBtnRev = self:get_template_child(Gtk.Revealer, "HomeBtnRev")
end
