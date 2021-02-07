Moonplayer:class("App", Gtk.Application)

function Moonplayer.App:_init()
  self.application_id = "com.github.M1que4s.Moonplayer"
end

function Moonplayer.App:do_startup()
  self._parent.do_startup(self)
  Hdy.init()
  Gst.init()

  -- Creates the window
  Moonplayer.Window({
    application = self,
    id          = "Window"
  })
end

function Moonplayer.App:do_activate()
  self.active_window:present()

  local flow = self.active_window.LocalView.FlowBox
  local path = GLib.get_user_special_dir(GLib.UserDirectory.DIRECTORY_MUSIC)
  local folder = Gio.File.new_for_path(path)

  if folder then
    local files = folder:enumerate_children("standard::name", Gio.FileQueryInfoFlags.NONE)

    if files then
      local info = files:next_file()
      local count = 0

      while info do
        if info:get_file_type() ~= "DIRECTORY" then
          local uri  = Gst.filename_to_uri(path.."/"..info:get_name())
          local disc = GstPbutils.Discoverer.new(10 * Gst.SECOND)
          local tags = disc:discover_uri(uri):get_tags()

          local item = Moonplayer.LocalItem({ uri = uri })

          if tags then
            item.title  = tags:get_string("title")
            item.artist = tags:get_string("artist")
            --item:set_artwork()
            flow:insert(item, count)
          else
            item.artist = info:get_name()
            flow:insert(item, count)
          end
        end

        info = files:next_file()
        count = count + 1
      end
    end
  else
    Log.warning("Error openning folder '"..path.."'")
  end
end