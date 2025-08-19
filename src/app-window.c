#include <glib-object.h>
#include <glib.h>

#include "app.h"
#include "utils.h"
#include "app-window.h"

static gpointer tpd_app_window_parent_class = NULL;

static GType tpd_app_window_get_type_once (void);

TpdAppWindow* tpd_app_window_new(TpdApp* app) {
  TpdAppWindow *self = (TpdAppWindow*) g_object_new(
    TPD_TYPE_APP_WINDOW,
    "application", app,
    NULL
  );

	return self;
}

static void tpd_app_window_class_init(TpdAppWindowClass *klass, gpointer _) {
	tpd_app_window_parent_class = g_type_class_peek_parent(klass);
}

static GType
tpd_app_window_get_type_once (void) {
	static const GTypeInfo type_info = {
    .class_size = sizeof (TpdAppWindowClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_app_window_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdAppWindow),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) NULL,
    .value_table = NULL
  };

	GType tpd_app_window_type_id;
	tpd_app_window_type_id = g_type_register_static(
    adw_application_window_get_type(),
    "TpdAppWindow",
    &type_info,
    0
  );

	return tpd_app_window_type_id;
}

GType tpd_app_window_get_type (void) {
	static volatile gsize tpd_app_window_type_id__once = 0;

  PUSH_IGNORE_DISCARDS_VOLATILE
	if (g_once_init_enter (&tpd_app_window_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
		GType tpd_app_window_type_id;
		tpd_app_window_type_id = tpd_app_window_get_type_once ();
		g_once_init_leave (&tpd_app_window_type_id__once, tpd_app_window_type_id);
	}
	return tpd_app_window_type_id__once;
}