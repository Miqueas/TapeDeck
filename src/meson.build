src = [
  # GResources
  resources,
  # Vala sources
  'App.vala',
  'Header.vala',
  'Sidebar.vala',
  'Controls.vala',
  'ViewItem.vala',
  'TrackInfo.vala',
  'AppWindow.vala',
  'SidebarItem.vala'
]

executable(meson.project_name(), src,
  dependencies: deps,
  install: true,
  # Windows specific, see the Meson doc for details
  # win_subsystem: 'windows'
)