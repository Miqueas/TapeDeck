import gintro/[gtk4, adw, gobject, gio]

const appID = "io.github.Miqueas.TapeDeck"

proc onActivate(self: adw.Application) =
  let win = adw.newApplicationWindow(self)
  win.present()

let app = adw.newApplication(appID, ApplicationFlagsDefaultFlags)
app.connect("activate", onActivate)

discard app.run()