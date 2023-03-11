import gintro/[gtk4, adw, gobject, gio]

const appID = "io.github.Miqueas.TapeDeck"

proc onStartup(self: adw.Application) =
  let win = adw.newApplicationWindow(self)
  win.setDefaultSize(400, 300)

proc onActivate(self: adw.Application) =
  let win = self.activeWindow()
  win.present()

let app = adw.newApplication(appID, ApplicationFlagsDefaultFlags)
app.connect("startup", onStartup)
app.connect("activate", onActivate)

discard app.run()