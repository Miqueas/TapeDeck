Moonplayer:class("LibraryView", Hdy.Clamp)

function Moonplayer.LibraryView:_class_init(Klass)
  Klass:set_template_from_resource("/com/github/Miqueas/Moonplayer/Templates/LibraryView.ui")
  Klass:bind_template_child_full("FlowBox", true, 0)

  local signals = {}
  --[[
  signals["local-item-added"] = GObject.signal_new(
    "local-item-added",
    Moonplayer.LibraryView,
    GObject.SignalFlags.RUN_LAST,
    0, nil, nil, nil,
    GObject.Type.NONE,
    1, Moonplayer.LocalItem
  )]]

  function Klass:set_property(id, val, spec)
    if id == 1 then
      self.priv.FlowBox = val:get_object()
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, spec)
    end
  end

  function Klass:get_property(id, val, spec)
    if id == 1 then
      val:set_object(self.priv.FlowBox)
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, spec)
    end
  end

  Klass:install_property(1, GObject.ParamSpecObject(
      "FlowBox", "Flow Box", "Music items view",
      Gtk.FlowBox,
      {
        GObject.ObjectConstructParam.PARAM_STATIC_STRINGS,
        GObject.ParamFlags.READABLE,
        GObject.ParamFlags.PRIVATE
      }
    )
  )
end

function Moonplayer.LibraryView:_init()
  self:init_template()

  self.priv.FlowBox = self:get_template_child(Moonplayer.LibraryView, "FlowBox")
end