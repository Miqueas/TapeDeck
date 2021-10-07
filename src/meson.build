src = [
  # GResources
  resources,
  # Vala sources
  'App.vala',
  'Title.vala',
  'Header.vala',
  'Controls.vala',
  'ViewItem.vala',
  'AppWindow.vala',
]

executable(meson.project_name(), src,
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  win_subsystem: 'windows'
)