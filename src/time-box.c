#include "utils.h"
#include "time-box.h"

static gpointer tpd_time_box_parent_class = NULL;

TpdTimeBox* tpd_time_box_new(void) {
  TpdTimeBox* self = (TpdTimeBox*) g_object_new(
    TPD_TYPE_TIME_BOX,
    "spacing", 10,
    "orientation", GTK_ORIENTATION_HORIZONTAL,
    "halign", GTK_ALIGN_CENTER,
    NULL
  );

  return self;
}

static void tpd_time_box_do_constructed(GObject* base) {
  TpdTimeBox* self = TPD_TIME_BOX(base);
  GtkLabel* timeElapsed = self->timeElapsed;
  GtkScale* timeSlider = self->timeSlider;
  GtkLabel* timeTotal = self->timeTotal;

  g_object_set(timeSlider, "width-request", 280, NULL);

  gtk_box_append(GTK_BOX(self), GTK_WIDGET(timeElapsed));
  gtk_box_append(GTK_BOX(self), GTK_WIDGET(timeSlider));
  gtk_box_append(GTK_BOX(self), GTK_WIDGET(timeTotal));
}

static void tpd_time_box_finalize(GObject * obj) {
  TpdTimeBox* self = TPD_TIME_BOX(obj);
  CLEAR(self->timeElapsed);
  CLEAR(self->timeSlider);
  CLEAR(self->timeTotal);
  G_OBJECT_CLASS(tpd_time_box_parent_class)->finalize(obj);
}

static void tpd_time_box_class_init(TpdTimeBoxClass * klass, gpointer _) {
  tpd_time_box_parent_class = g_type_class_peek_parent(klass);
  G_OBJECT_CLASS(klass)->constructed = tpd_time_box_do_constructed;
  G_OBJECT_CLASS(klass)->finalize = tpd_time_box_finalize;
}

static void tpd_time_box_instance_init(TpdTimeBox * self, gpointer klass) {
  GtkWidget* timeElapsed = gtk_label_new("00:00");
  GtkWidget* timeSlider = gtk_scale_new_with_range(
    GTK_ORIENTATION_HORIZONTAL,
    (gdouble) 0,
    (gdouble) 100,
    (gdouble) 2
  );
  GtkWidget* timeTotal = gtk_label_new("00:00");
  
  g_object_ref_sink(timeElapsed);
  g_object_ref_sink(timeSlider);
  g_object_ref_sink(timeTotal);

  self->timeElapsed = GTK_LABEL(timeElapsed);
  self->timeSlider = GTK_SCALE(timeSlider);
  self->timeTotal = GTK_LABEL(timeTotal);
}

static GType tpd_time_box_get_type_once (void) {
  static const GTypeInfo g_define_type_info = {
    .class_size = sizeof (TpdTimeBoxClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_time_box_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdTimeBox),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) tpd_time_box_instance_init,
    .value_table = NULL
  };

  GType tpd_time_box_type_id = g_type_register_static(
    gtk_box_get_type(),
    "TpdTimeBox",
    &g_define_type_info,
    0
  );

  return tpd_time_box_type_id;
}

GType tpd_time_box_get_type (void) {
  static volatile gsize tpd_time_box_type_id__once = 0;

  PUSH_IGNORE_DISCARDS_VOLATILE
  if (g_once_init_enter (&tpd_time_box_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
    GType tpd_time_box_type_id = tpd_time_box_get_type_once();
    g_once_init_leave(&tpd_time_box_type_id__once, tpd_time_box_type_id);
  }

  return tpd_time_box_type_id__once;
}