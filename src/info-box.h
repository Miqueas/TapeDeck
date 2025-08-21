#ifndef __TPD_INFO_BOX_H__
#define __TPD_INFO_BOX_H__

#include "time-box.h"

#define TPD_TYPE_INFO_BOX (tpd_info_box_get_type())
#define TPD_INFO_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), TPD_TYPE_INFO_BOX, TpdInfoBox))
#define TPD_INFO_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), TPD_TYPE_INFO_BOX, TpdInfoBoxClass))
#define TPD_IS_INFO_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), TPD_TYPE_INFO_BOX))
#define TPD_IS_INFO_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass), TPD_TYPE_INFO_BOX))
#define TPD_INFO_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), TPD_TYPE_INFO_BOX, TpdInfoBoxClass))

typedef struct _TpdInfoBox TpdInfoBox;
typedef struct _TpdInfoBoxClass TpdInfoBoxClass;
typedef struct _TpdInfoBoxPrivate TpdInfoBoxPrivate;

struct _TpdInfoBox {
  GtkBox parent_instance;
  TpdInfoBoxPrivate* priv;
  GtkLabel* songTitle;
  GtkLabel* songArtist;
  TpdTimeBox* timeBox;
  // TpdPlaybackBox* playbackBox;
  // TpdVolumeBox* volumeBox;
};

struct _TpdInfoBoxClass {
  GtkBoxClass parent_class;
};

GType tpd_info_box_get_type(void) G_GNUC_CONST;
G_DEFINE_AUTOPTR_CLEANUP_FUNC(TpdInfoBox, g_object_unref)
TpdInfoBox* tpd_info_box_new(void);

#endif