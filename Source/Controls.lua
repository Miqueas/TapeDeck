Moonplayer:class("Controls", Hdy.Clamp)

function Moonplayer.Controls:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Controls.ui")
end

function Moonplayer.Controls:_init()
  self:init_template()
end