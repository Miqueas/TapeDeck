FROM gitpod/workspace-full-vnc

RUN brew install gtk4 vala meson ninja libmpdclient gstreamer sassc
RUN brew install vala-language-server gst-plugins-base gst-plugins-good