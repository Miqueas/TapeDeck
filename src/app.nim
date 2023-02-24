import gintro/[gtk4, adw, gobject, gio]

proc appActivate(self: adw.Application) =
  let win = adw.newApplicationWindow(self)
  win.present()

let app = adw.newApplication("io.github.Miqueas.TapeDeck", ApplicationFlagsDefaultFlags)
app.connect("activate", appActivate)

discard app.run()