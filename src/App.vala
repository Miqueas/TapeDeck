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
    // this.style_manager.color_scheme = Adw.ColorScheme.PREFER_DARK;

    typeof(Header).ensure();
    typeof(Sidebar).ensure();
    typeof(Controls).ensure();
    typeof(ViewItem).ensure();
    typeof(TrackInfo).ensure();
    typeof(SidebarItem).ensure();
  
    new AppWindow(this);
  }
}