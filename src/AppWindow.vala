[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/AppWindow.ui")]
public class Tpd.AppWindow : Adw.ApplicationWindow {
  [GtkChild]
  private unowned Tpd.Header _header;

  [GtkChild]
  private unowned Tpd.Sidebar _sidebar;

  public AppWindow(App app) {
    Object(application: app);
  }

  construct {
    var size_group = new Gtk.SizeGroup(Gtk.SizeGroupMode.VERTICAL);
    size_group.add_widget(this._header);
    size_group.add_widget(this._sidebar._sidebar_header);
  }
}