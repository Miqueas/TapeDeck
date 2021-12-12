FROM gitpod/workspace-full-vnc

# Installs Flatpak
RUN sudo apt update
RUN sudo apt upgrade -y
RUN sudo apt install apt-utils dbus -y
RUN sudo add-apt-repository ppa:flatpak/stable -y
RUN sudo apt update
RUN sudo apt upgrade -y
RUN sudo apt install flatpak -y

# Add flathub repository
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Add gnome-nightly flatpak repository
RUN flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo