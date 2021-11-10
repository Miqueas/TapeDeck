[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/SidebarItem.ui")]
public class Tpd.SidebarItem : Gtk.Box {
  [GtkChild]
  private unowned Gtk.Image _img;

  [GtkChild]
  private unowned Gtk.Label _lbl;

  public string label { get; set; }
  public string resource { get; set; }
  public string icon_name { get; set; }

  construct {
    this.bind_property("label", this._lbl, "label", BindingFlags.SYNC_CREATE);
    this.bind_property("resource", this._img, "resource", BindingFlags.SYNC_CREATE);
    this.bind_property("icon-name", this._img, "icon-name", BindingFlags.SYNC_CREATE);
  }
}