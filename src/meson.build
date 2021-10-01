gnome = import('gnome')

src = [
  'App.vala',
  'Header.vala',
  'Controls.vala',
  'AppWindow.vala'
]

src += gnome.compile_resources('Resources', 'Resources.xml')

executable(meson.project_name(), src,
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  win_subsystem: 'windows'
)