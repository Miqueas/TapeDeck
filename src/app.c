#include <gio/gio.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <glib.h>
#include <gtk/gtk.h>
#include <adwaita.h>

#include "app.h"
#include "utils.h"
#include "consts.h"
#include "window.h"

static gpointer tpd_app_parent_class = NULL;

static void tpd_app_do_startup(GApplication *base);
static void tpd_app_do_activate(GApplication *base);
static GType tpd_app_get_type_once(void);

TpdApp* tpd_app_new(void) {
  TpdApp *self = (TpdApp *) g_object_new(
    TPD_TYPE_APP,
    "application-id", TPD_APP_ID,
    NULL
  );

	return self;
}

static void tpd_app_do_activate(GApplication *base) {
	TpdApp *self = TPD_APP(base);
  GtkWindow *window = gtk_application_get_active_window(GTK_APPLICATION(self));

	if (window != NULL) gtk_window_present(window);
}

static void tpd_app_do_startup(GApplication *base) {
	TpdApp* self = TPD_APP(base);
  AdwStyleManager* manager;

	G_APPLICATION_CLASS(tpd_app_parent_class)->startup(G_APPLICATION(self));
	manager = adw_application_get_style_manager(ADW_APPLICATION(self));
	adw_style_manager_set_color_scheme(manager, ADW_COLOR_SCHEME_PREFER_DARK);

  // By giving `self` to `tpd_window_new`, the window gets associated with the
  // application automatically.
  TpdWindow* window = tpd_window_new(self);
  g_object_ref_sink(window);
  if (window != NULL) g_object_unref(window);
}

static void tpd_app_class_init(TpdAppClass *klass, gpointer _) {
	tpd_app_parent_class = g_type_class_peek_parent(klass);
	G_APPLICATION_CLASS(klass)->activate =
    (void (*) (GApplication*)) tpd_app_do_activate;
	G_APPLICATION_CLASS(klass)->startup =
    (void (*) (GApplication*)) tpd_app_do_startup;
}

static GType tpd_app_get_type_once (void) {
	static const GTypeInfo type_info = {
    .class_size = sizeof (TpdAppClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_app_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdApp),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) NULL,
    .value_table = NULL
  };

	GType tpd_app_type_id = g_type_register_static(
    adw_application_get_type(),
    "TpdApp",
    &type_info,
    0
  );

	return tpd_app_type_id;
}

GType tpd_app_get_type(void) {
	static volatile gsize tpd_app_type_id__once = 0;

  // I'm not an expert but: from what I know about `volatile`, I prefer the
  // compiler to ignore that calling `g_once_init_enter` discards the qualifier,
  // than make it a non-volatile variable.
  PUSH_IGNORE_DISCARDS_VOLATILE
  if (g_once_init_enter(&tpd_app_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
    GType tpd_app_type_id = tpd_app_get_type_once();
		g_once_init_leave(&tpd_app_type_id__once, tpd_app_type_id);
	}

	return tpd_app_type_id__once;
}