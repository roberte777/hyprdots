#!/bin/bash
#|---/ /+-----------------------------------+---/ /|#
#|--/ /-| Script to install flatpaks (user) |--/ /-|#
#|-/ /--| Prasanth Rangan                   |-/ /--|#
#|/ /---+-----------------------------------+/ /---|#

source global_fn.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname $(realpath $0))..."
    exit 1
fi

if ! pkg_installed flatpak
    then
    sudo pacman -S flatpak
fi

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flats=""

while read fpk
do
    flats=`echo ${flats} ${fpk}`
done < custom_flat.lst

flatpak install --user -y flathub ${flats}
flatpak remove --unused

flatpak --user override --filesystem=~/.themes
flatpak --user override --filesystem=~/.icons
flatpak --user override --env=GTK_THEME=Gruvbox-Dark-B
flatpak --user override --env=ICON_THEME=Tela-circle-dracula

