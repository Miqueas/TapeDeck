[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/TrackInfo.ui")]
public class TapeDeck.TrackInfo : Gtk.Box {
  construct {
    var ev = new Gtk.GestureClick();
    ev.pressed.connect(this.on_pressed);

    this.add_controller(ev);
  }

  private void on_pressed(int n_press, double x, double y) {
    print("Clicked %d times!\n", n_press);
  }
}