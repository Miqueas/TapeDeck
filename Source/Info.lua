Moonplayer:class("Info", Hdy.Clamp)

--[[ TODO Properties:

img?
img_size?

]]

function Moonplayer.Info:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/Info.ui")
  klass:bind_template_child_full("Title", true, 0)
  klass:bind_template_child_full("Artist", true, 0)
  klass:bind_template_child_full("MediaArtEv", true, 0)
  klass:bind_template_child_full("MediaArtImg", true, 0)

  function klass:set_property(id, value, pspec)
    if id == 1 then
      self.priv.title = value:get_string()
    elseif id == 2 then
      self.priv.artist = value:get_string()
    elseif id == 3 then
      self.priv.img = value:get_object()
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  function klass:get_property(id, value, pspec)
    if id == 1 then
      value:set_string(self.priv.title)
    elseif id == 2 then
      value:set_string(self.priv.artist)
    elseif id == 3 then
      value:set_object(self.priv.img)
    else
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  klass:install_property(1, GObject.ParamSpecString(
      "title", "Title", "Media title", "Title",
      { "READWRITE", "CONSTRUCT" }
    )
  )

  klass:install_property(2, GObject.ParamSpecString(
      "artist", "Artist", "Media artist name", "Artist",
      { "READWRITE", "CONSTRUCT" }
    )
  )

  klass:install_property(3, GObject.ParamSpecObject(
      "img", "Image", "Media album artwork", GdkPixbuf.Pixbuf,
      { "READWRITE", "CONSTRUCT" }
    )
  )
end

function Moonplayer.Info:_init()
  self:init_template()

  self.priv.Title = self:get_template_child(Moonplayer.Info, "Title")
  self.priv.Artist = self:get_template_child(Moonplayer.Info, "Artist")
  self.priv.MediaArtEv = self:get_template_child(Moonplayer.Info, "MediaArtEv")
  self.priv.MediaArtImg = self:get_template_child(Moonplayer.Info, "MediaArtImg")

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

  GObject.Binding.bind_property(
    self, "img",
    self.priv.MediaArtImg, "pixbuf",
    GObject.BindingFlags.DEFAULT
  )
end