Moonplayer:class("LocalItem", Gtk.FlowBoxChild)

function Moonplayer.LocalItem:_class_init(klass)
  klass:set_template_from_resource("/com/github/M1que4s/Moonplayer/Templates/LocalItem.ui")
  klass:bind_template_child_full("Title", true, 0)
  klass:bind_template_child_full("Artist", true, 0)
  klass:bind_template_child_full("Artwork", true, 0)

  function klass:set_property(id, value, pspec)
    if id == 1 then
      self.priv.title = value:get_string()
    elseif id == 2 then
      self.priv.artist = value:get_string()
    elseif id == 3 then
      self.priv.uri = value:get_string()
    else
      -- Invalid property
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  function klass:get_property(id, value, pspec)
    if id == 1 then
      value:set_string(self.priv.title)
    elseif id == 2 then
      value:set_string(self.priv.artist)
    elseif id == 3 then
      value:set_string(self.priv.uri)
    else
      -- Invalid property
      GObject.OBJECT_WARN_INVALID_PROPERTY_ID(self, id, pspec)
    end
  end

  klass:install_property(1, GObject.ParamSpecString(
      "title", "Title", "Media title", "",
      { GObject.ParamFlags.READWRITE }
    )
  )

  klass:install_property(2, GObject.ParamSpecString(
      "artist", "Artist", "Media artist name", "",
      { GObject.ParamFlags.READWRITE }
    )
  )

  klass:install_property(3, GObject.ParamSpecString(
      "uri", "URI", "File URI", "",
      { GObject.ParamFlags.READWRITE }
    )
  )
end

function Moonplayer.LocalItem:_init()
  self:init_template()

  self.priv.Title = self:get_template_child(Moonplayer.LocalItem, "Title")
  self.priv.Artist = self:get_template_child(Moonplayer.LocalItem, "Artist")
  self.priv.Artwork = self:get_template_child(Moonplayer.LocalItem, "Artwork")

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

function Moonplayer.LocalItem:set_artwork()
  local disc = GstPbutils.Discoverer.new(10 * Gst.SECOND)
  local tags = disc:discover_uri(self.uri):get_tags()
  local pix

  if tags then
    local sample = tags:get_sample("image") or tags:get_sample("preview-image")

    if sample then
      local map    = sample:get_buffer():map(Gst.MapFlags.READ)
      local bytes  = GLib.Bytes.new(map.data)
      local stream = Gio.MemoryInputStream.new_from_bytes(bytes)

      pix = GdkPixbuf.Pixbuf.new_from_stream(stream)
      pix = pix:scale_simple(96, 96, GdkPixbuf.InterpType.BILINEAR)

      stream:close()
    end
  end

  self.priv.Artwork:set_image_load_func(function ()
    return pix
  end)
end