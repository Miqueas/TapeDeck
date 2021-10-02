project('com.github.Miqueas.TapeDeck', 'vala', 'c',
  version: '0.1.0',
  license: 'Zlib',
  meson_version: '>=0.56.0',
  default_options: [ 'warning_level=2' ]
)

deps = [
  dependency('gtk4',          version: '>=4.4'),
  dependency('libadwaita-1',  version: '>=1.0', fallback: 'libadwaita'),
  dependency('gstreamer-1.0', version: '>=1.18'),
  dependency('libmpdclient',  version: '>=2.19')
]

subdir('src')