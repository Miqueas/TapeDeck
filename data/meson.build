gnome = import('gnome')

blp_compiler = find_program('blueprint-compiler')
blp_src = [
  'ui/app-window.blp'
]

blp = custom_target('blp',
  input: blp_src,
  output: '.',
  command: [ blp_compiler, 'batch-compile', '@OUTDIR@', '@CURRENT_SOURCE_DIR@', '@INPUT@' ]
)

gres_dir = meson.current_build_dir()
gres = gnome.compile_resources(
  meson.project_name(),
  meson.project_name() + '.gresources.xml',
  dependencies: blp,
  source_dir: [ gres_dir ]
)