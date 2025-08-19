#include <adwaita.h>

#define TPD_TYPE_HEADER (tpd_header_get_type())
#define TPD_HEADER(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), TPD_TYPE_HEADER, TpdHeader))
#define TPD_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), TPD_TYPE_HEADER, TpdHeaderClass))
#define TPD_IS_HEADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), TPD_TYPE_HEADER))
#define TPD_IS_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass), TPD_TYPE_HEADER))
#define TPD_HEADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), TPD_TYPE_HEADER, TpdHeaderClass))

typedef struct _TpdHeader TpdHeader;
typedef struct _TpdHeaderClass TpdHeaderClass;
typedef struct _TpdHeaderPrivate TpdHeaderPrivate;

struct _TpdHeader {
	AdwBin parent_instance;
	TpdHeaderPrivate* priv;
	GtkRevealer* revealer;
	GtkWindowControls* controls;
};

struct _TpdHeaderClass {
	AdwBinClass parent_class;
};

GType tpd_header_get_type(void) G_GNUC_CONST ;
G_DEFINE_AUTOPTR_CLEANUP_FUNC(TpdHeader, g_object_unref)
TpdHeader* tpd_header_new (void);