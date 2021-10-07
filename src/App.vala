public class TapeDeck.App : Adw.Application {
  public App() {
    Object(application_id: "com.github.Miqueas.TapeDeck");
  }

  static int main(string[] args) {
    return new App().run(args);
  }

  protected override void activate() {
    this.active_window?.present();
  }

  protected override void startup() {
    base.startup();
    this.style_manager.color_scheme = Adw.ColorScheme.PREFER_DARK;

    typeof(Title).ensure();
    typeof(Header).ensure();
    typeof(Controls).ensure();
    typeof(ViewItem).ensure();
  
    new AppWindow(this);
  }
}