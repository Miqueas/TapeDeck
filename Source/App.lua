Moonplayer:class("App", Gtk.Application)

local flow

local function ScanLocalFiles(flow)
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
            item:set_artwork()
            flow:insert(item, count)
          else
            item.title = info:get_name()
            flow:insert(item, count)
          end
        end

        info = files:next_file()
        count = count + 1
        coroutine.yield()
      end
    end
  else
    Log.warning("Error openning folder '"..path.."'")
  end
end

local co = coroutine.create(ScanLocalFiles)

local function ScannerWrap()
  stat = coroutine.resume(co, flow)

  if stat then return true else return false end
end

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
  flow = self.active_window.LocalView.FlowBox
  GLib.timeout_add(400, 400, ScannerWrap)

  self.active_window:present()
end