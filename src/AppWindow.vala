[GtkTemplate (ui = "/com/github/Miqueas/TapeDeck/AppWindow.ui")]
public class TapeDeck.AppWindow : Adw.ApplicationWindow {
  public AppWindow(App app) {
    Object(application: app);
  }
}