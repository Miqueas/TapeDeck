#include "app.h"
#include "utils.h"
#include "window.h"

static gpointer tpd_window_parent_class = NULL;

static GType tpd_window_get_type_once (void);

TpdWindow* tpd_window_new(TpdApp* app) {
  TpdWindow *self = (TpdWindow*) g_object_new(
    TPD_TYPE_WINDOW,
    "application", app,
    NULL
  );

  return self;
}

static void tpd_window_class_init(TpdWindowClass *klass, gpointer _) {
  tpd_window_parent_class = g_type_class_peek_parent(klass);
}

static GType
tpd_window_get_type_once (void) {
  static const GTypeInfo type_info = {
    .class_size = sizeof (TpdWindowClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_window_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdWindow),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) NULL,
    .value_table = NULL
  };

  GType tpd_app_window_type_id;
  tpd_app_window_type_id = g_type_register_static(
    adw_application_window_get_type(),
    "TpdWindow",
    &type_info,
    0
  );

  return tpd_app_window_type_id;
}

GType tpd_window_get_type (void) {
  static volatile gsize tpd_window_type_id__once = 0;

  // I'm not an expert but: from what I know about `volatile`, I prefer the
  // compiler to ignore that calling `g_once_init_enter` discards the qualifier,
  // than make it a non-volatile variable.
  PUSH_IGNORE_DISCARDS_VOLATILE
  if (g_once_init_enter (&tpd_window_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
    GType tpd_window_type_id = tpd_window_get_type_once ();
    g_once_init_leave(&tpd_window_type_id__once, tpd_window_type_id);
  }

  return tpd_window_type_id__once;
}