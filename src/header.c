#include "utils.h"
#include "header.h"

static gpointer tpd_header_parent_class = NULL;

static void tpd_header_do_constructed(GObject* base);
static void tpd_header_finalize(GObject* obj);
static GType tpd_header_get_type_once(void);

static void tpd_header_do_constructed(GObject* base) {
  TpdHeader* self = TPD_HEADER(base);
  GtkRevealer* revealer = self->revealer;
  GtkWindowControls* controls = self->controls;

  adw_bin_set_child(ADW_BIN(self), GTK_WIDGET(revealer));

  gtk_widget_set_halign(GTK_WIDGET(controls), GTK_ALIGN_END);
  gtk_widget_set_hexpand(GTK_WIDGET(controls), TRUE);

  gtk_revealer_set_child(revealer, GTK_WIDGET(controls));
  gtk_revealer_set_reveal_child(revealer, TRUE);
  gtk_revealer_set_transition_type(
    revealer,
    GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
  );
}

TpdHeader* tpd_header_new (void) {
  TpdHeader* self = (TpdHeader*) g_object_new(TPD_TYPE_HEADER, NULL);
  return self;
}

static void tpd_header_class_init (TpdHeaderClass *klass, gpointer _) {
  tpd_header_parent_class = g_type_class_peek_parent(klass);
  G_OBJECT_CLASS(klass)->constructed = tpd_header_do_constructed;
  G_OBJECT_CLASS(klass)->finalize = tpd_header_finalize;
}

static void tpd_header_instance_init (TpdHeader * self, gpointer klass) {
  GtkWidget* revealer = gtk_revealer_new();
  GtkWidget* controls = gtk_window_controls_new(GTK_PACK_END);

  g_object_ref_sink(revealer);
  g_object_ref_sink(controls);

  self->revealer = GTK_REVEALER(revealer);
  self->controls = GTK_WINDOW_CONTROLS(controls);
}

static void tpd_header_finalize (GObject* obj) {
  TpdHeader* self = TPD_HEADER(obj);
  CLEAR(self->revealer);
  CLEAR(self->controls);
  G_OBJECT_CLASS (tpd_header_parent_class)->finalize (obj);
}

static GType tpd_header_get_type_once (void) {
  static const GTypeInfo g_define_type_info = {
    .class_size = sizeof (TpdHeaderClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_header_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdHeader),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) tpd_header_instance_init,
    .value_table = NULL
  };

  GType tpd_header_type_id;
  tpd_header_type_id = g_type_register_static(
    adw_bin_get_type(),
    "TpdHeader",
    &g_define_type_info,
    0
  );

  return tpd_header_type_id;
}

GType tpd_header_get_type (void) {
  static volatile gsize tpd_header_type_id__once = 0;

  // I'm not an expert but: from what I know about `volatile`, I prefer the
  // compiler to ignore that calling `g_once_init_enter` discards the qualifier,
  // than make it a non-volatile variable.
  PUSH_IGNORE_DISCARDS_VOLATILE
  if (g_once_init_enter (&tpd_header_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
    GType tpd_header_type_id = tpd_header_get_type_once ();
    g_once_init_leave(&tpd_header_type_id__once, tpd_header_type_id);
  }

  return tpd_header_type_id__once;
}