Moonplayer:class("App", Gtk.Application)

function Moonplayer.App:_init()
  self.application_id = "com.github.M1que4s.Moonplayer"
end

function Moonplayer.App:do_startup()
  self._parent.do_startup(self)
  Hdy.init()

  -- Creates the window
  Moonplayer.Window({
    application = self,
    id          = "Window"
  })
end

function Moonplayer.App:do_activate()
  self.active_window:present()
end