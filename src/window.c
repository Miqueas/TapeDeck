#include "app.h"
#include "utils.h"
#include "consts.h"
#include "info-box.h"
#include "header.h"
#include "window.h"

static gpointer tpd_window_parent_class = NULL;

TpdWindow* tpd_window_new(TpdApp* app) {
  TpdWindow *self = (TpdWindow*) g_object_new(
    TPD_TYPE_WINDOW,
    "application", app,
    NULL
  );

  return self;
}

static gboolean tpd_window_do_close_request(GtkWindow* base) {
  TpdWindow* self = TPD_WINDOW(base);
  GtkApplication* app = gtk_window_get_application(GTK_WINDOW(self));
  // TODO: If the "keep running in the background" option is enabled, don't quit
  g_application_quit(G_APPLICATION(app));
  return FALSE;
}

static void tpd_window_do_constructed(GObject* base) {
  TpdWindow* self = TPD_WINDOW(base);
  GtkStack* listStack = self->listStack;
  GtkListView* queueView = self->queueView;
  GtkListView* databaseView = self->databaseView;
  GtkStackSwitcher* listStackSwitcher = self->listStackSwitcher;
  GtkBox* mainBox = self->mainBox;
  GtkStack* mainStack = self->mainStack;
  TpdHeader* header = tpd_header_new();
  TpdInfoBox* infoBox = tpd_info_box_new();

  g_object_set(listStack, "height-request", 400, NULL);
  gtk_stack_add_titled(listStack, GTK_WIDGET(queueView), "queue", "Now Playing");
  gtk_stack_add_titled(listStack, GTK_WIDGET(databaseView), "database", "Library");

  gtk_stack_switcher_set_stack(listStackSwitcher, listStack);
  gtk_widget_set_halign(GTK_WIDGET(listStackSwitcher), GTK_ALIGN_CENTER);

  gtk_widget_set_margin_start(GTK_WIDGET(mainBox), 12);
  gtk_widget_set_margin_end(GTK_WIDGET(mainBox), 12);
  gtk_widget_set_margin_top(GTK_WIDGET(mainBox), 12);
  gtk_widget_set_margin_bottom(GTK_WIDGET(mainBox), 12);
  g_object_ref_sink(header);
  g_object_ref_sink(infoBox);
  gtk_box_append(mainBox, GTK_WIDGET(header));
  gtk_box_append(mainBox, GTK_WIDGET(infoBox));
  CLEAR(header);
  CLEAR(infoBox);

  gtk_stack_add_named(mainStack, GTK_WIDGET(mainBox), "main_view");

  gtk_window_set_title(GTK_WINDOW(self), TPD_APP_TITLE);
  gtk_window_set_resizable(GTK_WINDOW(self), FALSE);
  adw_application_window_set_content(
    ADW_APPLICATION_WINDOW(self),
    GTK_WIDGET(mainStack)
  );
}

static void tpd_window_finalize(GObject* obj) {
  TpdWindow* self = TPD_WINDOW(obj);
  CLEAR(self->queueView);
  CLEAR(self->databaseView);
  CLEAR(self->listStack);
  CLEAR(self->listStackSwitcher);
  CLEAR(self->mainBox);
  CLEAR(self->mainStack);
  G_OBJECT_CLASS(tpd_window_parent_class)->finalize(obj);
}

static void tpd_window_class_init(TpdWindowClass *klass, gpointer _) {
  tpd_window_parent_class = g_type_class_peek_parent(klass);
  GTK_WINDOW_CLASS(klass)->close_request = tpd_window_do_close_request;
  G_OBJECT_CLASS(klass)->constructed = tpd_window_do_constructed;
  G_OBJECT_CLASS(klass)->finalize = tpd_window_finalize;
}

static void tpd_window_instance_init(TpdWindow* self, gpointer klass) {
  GtkWidget* queueView = gtk_list_view_new(NULL, NULL);
  GtkWidget* databaseView = gtk_list_view_new(NULL, NULL);
  GtkWidget* listStack = gtk_stack_new();
  GtkWidget* listStackSwitcher = gtk_stack_switcher_new();
  GtkWidget* mainBox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
  GtkWidget* mainStack = gtk_stack_new();

  g_object_ref_sink(queueView);
  g_object_ref_sink(databaseView);
  g_object_ref_sink(listStack);
  g_object_ref_sink(listStackSwitcher);
  g_object_ref_sink(mainBox);
  g_object_ref_sink(mainStack);

  self->queueView = GTK_LIST_VIEW(queueView);
  self->databaseView = GTK_LIST_VIEW(databaseView);
  self->listStack = GTK_STACK(listStack);
  self->listStackSwitcher = GTK_STACK_SWITCHER(listStackSwitcher);
  self->mainBox = GTK_BOX(mainBox);
  self->mainStack = GTK_STACK(mainStack);
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
    .instance_init = (GInstanceInitFunc) tpd_window_instance_init,
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