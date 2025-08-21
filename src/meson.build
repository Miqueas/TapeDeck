deps = [
  dependency('libadwaita-1',  version: '>=1.0'),
  dependency('libmpdclient')
]

src = [
  'info-box.c',
  'header.c',
  'window.c',
  'app.c',
  'main.c',
]

executable(meson.project_name(), src,
  install: true,
  dependencies: deps,
  # Windows specific, see the Meson doc for details
  # win_subsystem: 'windows'
)