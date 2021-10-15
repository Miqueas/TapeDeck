[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/Title.ui")]
public class TapeDeck.Title : Adw.Bin {
  construct {
    var ev = new Gtk.GestureClick();
    ev.pressed.connect(this.on_pressed);

    this.add_controller(ev);
  }

  private void on_pressed(int n_press, double x, double y) {
    print("Clicked %d times!\n", n_press);
  }
}