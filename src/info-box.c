#include "utils.h"
#include "consts.h"
#include "time-box.h"
#include "info-box.h"

static gpointer tpd_info_box_parent_class = NULL;

TpdInfoBox* tpd_info_box_new(void) {
  TpdInfoBox* self = (TpdInfoBox*) g_object_new(
    TPD_TYPE_INFO_BOX,
    "spacing", 10,
    "orientation", GTK_ORIENTATION_VERTICAL,
    "margin-start", 60,
    "margin-end", 60,
    "margin-top", 40,
    "margin-bottom", 40,
    NULL
  );

  return self;
}

static void tpd_info_box_do_constructed(GObject* base) {
  TpdInfoBox* self = TPD_INFO_BOX(base);
  GtkLabel* songTitle = self->songTitle;
  GtkLabel* songArtist = self->songArtist;
  TpdTimeBox* timeBox = self->timeBox;
  // TpdPlaybackBox* playbackBox = self->playbackBox;
  // TpdVolumeBox* volumeBox = self->volumeBox;

  gtk_label_set_use_markup(songTitle, TRUE);

  gtk_box_append(GTK_BOX(self), GTK_WIDGET(songTitle));
  gtk_box_append(GTK_BOX(self), GTK_WIDGET(songArtist));
  gtk_box_append(GTK_BOX(self), GTK_WIDGET(timeBox));
  // gtk_box_append(GTK_BOX(self), GTK_WIDGET(playbackBox));
  // gtk_box_append(GTK_BOX(self), GTK_WIDGET(volumeBox));
}

static void tpd_info_box_finalize(GObject * obj) {
  TpdInfoBox* self = TPD_INFO_BOX(obj);
  CLEAR(self->songTitle);
  CLEAR(self->songArtist);
  CLEAR(self->timeBox);
  // CLEAR(self->playbackBox);
  // CLEAR(self->volumeBox);
  G_OBJECT_CLASS(tpd_info_box_parent_class)->finalize(obj);
}

static void tpd_info_box_class_init (TpdInfoBoxClass* klass, gpointer _) {
  tpd_info_box_parent_class = g_type_class_peek_parent (klass);
  G_OBJECT_CLASS(klass)->constructed = tpd_info_box_do_constructed;
  G_OBJECT_CLASS(klass)->finalize = tpd_info_box_finalize;
}

static void tpd_info_box_instance_init(TpdInfoBox* self, gpointer klass) {
  gchar* songTitleText = g_strdup_printf(TPD_SONG_TITLE_FORMAT, TPD_APP_TITLE);
  GtkWidget* songTitle = gtk_label_new(songTitleText);
  GtkWidget* songArtist = gtk_label_new(TPD_APP_PHRASE);
  TpdTimeBox* timeBox = tpd_time_box_new();
  // TpdPlaybackBox* playbackBox;
  // TpdVolumeBox* volumeBox;

  g_object_ref_sink(songTitle);
  g_object_ref_sink(songArtist);
  g_object_ref_sink(timeBox);
  // g_object_ref_sink(playbackBox);
  // g_object_ref_sink(volumeBox);

  self->songTitle = GTK_LABEL(songTitle);
  self->songArtist = GTK_LABEL(songArtist);
  self->timeBox = timeBox;
  // self->playbackBox = playbackBox;
  // self->volumeBox = volumeBox;

  g_free(songTitleText);
  songTitleText = NULL;
}

static GType tpd_info_box_get_type_once(void) {
  static const GTypeInfo g_define_type_info = {
    .class_size = sizeof (TpdInfoBoxClass),
    .base_init = (GBaseInitFunc) NULL,
    .base_finalize = (GBaseFinalizeFunc) NULL,
    .class_init = (GClassInitFunc) tpd_info_box_class_init,
    .class_finalize = (GClassFinalizeFunc) NULL,
    .class_data = NULL,
    .instance_size = sizeof (TpdInfoBox),
    .n_preallocs = 0,
    .instance_init = (GInstanceInitFunc) tpd_info_box_instance_init,
    .value_table = NULL
  };

  GType tpd_info_box_type_id = g_type_register_static(
    gtk_box_get_type(),
    "TpdInfoBox",
    &g_define_type_info,
    0
  );

  return tpd_info_box_type_id;
}

GType tpd_info_box_get_type(void) {
  static volatile gsize tpd_info_box_type_id__once = 0;

  PUSH_IGNORE_DISCARDS_VOLATILE
  if (g_once_init_enter (&tpd_info_box_type_id__once)) {
  POP_IGNORE_DISCARDS_VOLATILE
    GType tpd_info_box_type_id = tpd_info_box_get_type_once();
    g_once_init_leave(&tpd_info_box_type_id__once, tpd_info_box_type_id);
  }
  return tpd_info_box_type_id__once;
}