deps = [
  dependency('libadwaita-1',  version: '>=1.0'),
  dependency('libmpdclient',  version: '>=2.19')
]

gresource = gnome.compile_resources(
  meson.project_name() + '.gresource',
  meson.project_name() + '.gresource.xml'
)

src = [
  # GResources
  gresource,
  # Vala sources
  'app.vala',
  'app-window.vala',
]

executable(meson.project_name(), src,
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  # win_subsystem: 'windows'
)