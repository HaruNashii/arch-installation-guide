# install nvidia drivers
sudo pacman -S --needed dkms nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader egl-wayland

# change the nvidia kernel module to support wayland
# necessary to use (gnome on wayland/hyprland, etc)
sudo echo options nvidia_drm modeset=1 | sudo tee /etc/modprobe.d/nvidia_drm.conf

# if user is using GDM enable the GDM to choose Wayland sessions
if ! [ -x "$(command -v gdm)" ]; then
	sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rule
fi

# prevent the initramfs from containing the nouveau module making sure the kernel cannot load it during early boot.
sudo sed -i 's/kms//g' /etc/mkinitcpio.conf

# regenerate the kernel modules
sudo mkinitcpio -p linux
