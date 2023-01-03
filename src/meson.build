deps = [
  dependency('libadwaita-1',  version: '>=1.0'),
  dependency('libmpdclient')
]

src = [
  # Vala sources
  'app.vala',
  'app-window.vala',
  'track-info.vala',
  # GResources
  gres
]

executable(meson.project_name(), src,
  vala_args: [
    '--target-glib=2.50',
    '--gresourcesdir=' + gres_dir
  ],
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  # win_subsystem: 'windows'
)