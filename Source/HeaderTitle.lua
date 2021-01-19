Moonplayer:class("HeaderTitle", Gtk.Box)

function Moonplayer.HeaderTitle:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/HeaderTitle.ui")
end

function Moonplayer.HeaderTitle:_init()
  self:init_template()
end
