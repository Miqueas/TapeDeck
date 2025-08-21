#ifndef __TPD_TIME_BOX_H__
#define __TPD_TIME_BOX_H__

#include <gtk/gtk.h>

G_BEGIN_DECLS

#define TPD_TYPE_TIME_BOX (tpd_time_box_get_type())
#define TPD_TIME_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), TPD_TYPE_TIME_BOX, TpdTimeBox))
#define TPD_TIME_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), TPD_TYPE_TIME_BOX, TpdTimeBoxClass))
#define TPD_IS_TIME_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), TPD_TYPE_TIME_BOX))
#define TPD_IS_TIME_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass), TPD_TYPE_TIME_BOX))
#define TPD_TIME_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), TPD_TYPE_TIME_BOX, TpdTimeBoxClass))

typedef struct _TpdTimeBox TpdTimeBox;
typedef struct _TpdTimeBoxClass TpdTimeBoxClass;
typedef struct _TpdTimeBoxPrivate TpdTimeBoxPrivate;

struct _TpdTimeBox {
  GtkBox parent_instance;
  TpdTimeBoxPrivate* priv;
  GtkLabel* timeElapsed;
  GtkScale* timeSlider;
  GtkLabel* timeTotal;
};

struct _TpdTimeBoxClass {
  GtkBoxClass parent_class;
};

GType tpd_time_box_get_type(void) G_GNUC_CONST;
G_DEFINE_AUTOPTR_CLEANUP_FUNC(TpdTimeBox, g_object_unref)
TpdTimeBox* tpd_time_box_new(void);

G_END_DECLS

#endif