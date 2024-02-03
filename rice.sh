#!/bin/bash

if ! command -v git &> /dev/null; then
    sudo pacman -Sy --noconfirm git
fi
git clone https://github.com/HaruNashii/dotfiles-hyprland.git
cd dotfiles-hyprland
chmod a+x install.sh
./install.sh
cd ..
