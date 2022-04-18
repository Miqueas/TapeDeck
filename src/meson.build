src = [
  'App.vala',
  'Header.vala',
  'Sidebar.vala',
  'Controls.vala',
  'ViewItem.vala',
  'TrackInfo.vala',
  'AppWindow.vala',
  'SidebarItem.vala'
]

deps = [
  dependency('gstreamer-1.0', version: '>=1.18'),
  dependency('libadwaita-1',  version: '>=1.0'),
  dependency('libmpdclient',  version: '>=2.19')
]

src += gnome.compile_resources(
  app_id + '.Resources'
  app_id + '.gresource.xml',
  c_name: app_id
)

executable(app_id, src,
  vala_args: '--target-glib=2.50'
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  # win_subsystem: 'windows'
)