[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/AppWindow.ui")]
public class TapeDeck.AppWindow : Adw.ApplicationWindow {
  [GtkChild]
  private unowned TapeDeck.Header _header;

  [GtkChild]
  private unowned TapeDeck.Sidebar _sidebar;

  public AppWindow(App app) {
    Object(application: app);
  }

  construct {
    var size_group = new Gtk.SizeGroup(Gtk.SizeGroupMode.VERTICAL);
    size_group.add_widget(this._header);
    size_group.add_widget(this._sidebar._sidebar_header);
  }
}