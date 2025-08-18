#include "app.h"

// #if !defined(__clang__) && defined(__GNUC__) && (__GNUC__ >= 14)
// #pragma GCC diagnostic warning "-Wincompatible-pointer-types"
// #elif defined(__clang__) && (__clang_major__ >= 16)
// #pragma clang diagnostic ignored "-Wincompatible-function-pointer-types"
// #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
// #endif

int main (int argc, char ** argv) {
  TpdApp *app = tpd_app_new();

  if (app == NULL) {
    fprintf(stderr, "tpd_app_new(): failed");
    return 1;
  }

  gint result = g_application_run(G_APPLICATION(app), argc, argv);
  g_object_unref(app);

	return result;
}