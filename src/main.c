#include "app.h"

int main (int argc, char ** argv) {
  TpdApp *app = tpd_app_new();

  if (app == NULL) {
    fprintf(stderr, "tpd_app_new(): failed");
    return 1;
  }

  gint result = g_application_run(G_APPLICATION(app), argc, argv);
  g_clear_object(&app);

	return result;
}