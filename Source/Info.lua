Moonplayer:class("Info", Gtk.EventBox)

-- Class constructor
function Moonplayer.Info:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Info.ui")
  klass:bind_template_child_full("Img", true, 0)
  klass:bind_template_child_full("Title", true, 0)
  klass:bind_template_child_full("Artist", true, 0)

  function klass:set_property(id, value, pspec)
    -- Moonplayer.Info.img property
    if id == 1 then
      self.priv.img = value:get_object()

    -- Moonplayer.Info.title property
    elseif id == 2 then
      self.priv.title = value:get_string()

    -- Moonplayer.Info.artist property
    elseif id == 3 then
      self.priv.artist = value:get_string()

    -- Invalid property
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  function klass:get_property(id, value, pspec)
    -- Moonplayer.Info.img property
    if id == 1 then
      value:set_object(self.priv.img)

    -- Moonplayer.Info.title property
    elseif id == 2 then
      value:set_string(self.priv.title)

    -- Moonplayer.Info.artist property
    elseif id == 3 then
      value:set_string(self.priv.artist)

    -- Invalid property
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  klass:install_property(1, GObject.ParamSpecObject(
      "img", "Image", "Media album artwork", GdkPixbuf.Pixbuf,
      { "READWRITE", "CONSTRUCT" }
    )
  )

  klass:install_property(2, GObject.ParamSpecString(
      "title", "Title", "Media title", "Moonplayer",
      { "READWRITE", "CONSTRUCT" }
    )
  )

  klass:install_property(3, GObject.ParamSpecString(
      "artist", "Artist", "Media artist name", "Astronauts music player",
      { "READWRITE", "CONSTRUCT" }
    )
  )
end

-- Instance constructor
function Moonplayer.Info:_init()
  self:init_template()

  self.priv.Img = self:get_template_child(Moonplayer.Info, "Img")
  self.priv.Title = self:get_template_child(Moonplayer.Info, "Title")
  self.priv.Artist = self:get_template_child(Moonplayer.Info, "Artist")

  GObject.Binding.bind_property(
    self, "img",
    self.priv.Img, "pixbuf",
    GObject.BindingFlags.DEFAULT
  )

  GObject.Binding.bind_property(
    self, "title",
    self.priv.Title, "label",
    GObject.BindingFlags.DEFAULT
  )

  GObject.Binding.bind_property(
    self, "artist",
    self.priv.Artist, "label",
    GObject.BindingFlags.DEFAULT
  )
end

-- TODO: do something when user clicks the info widget
function Moonplayer.Info:do_button_press_event()
end