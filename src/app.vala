public class Tpd.App : Adw.Application {
  public App() {
    Object(application_id: "io.github.Miqueas.TapeDeck");
  }

  static int main(string[] args) {
    return new App().run(args);
  }

  protected override void activate() {
    // weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
    // default_theme.add_resource_path("/com/github/Miqueas/TapeDeck");

    this.active_window?.present();
  }

  protected override void startup() {
    base.startup();
    // this.style_manager.color_scheme = Adw.ColorScheme.PREFER_DARK;
  
    new AppWindow(this);
  }
}