#!/bin/bash

# clear the terminal
clear

#change the system settings of the timezone to (Brazil, Sao Paulo)
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

#syncronize the timezone settings with the system
hwclock --systohc

#open the nano editor for you select your system language
nano /etc/locale.gen

#apply the locale.gen config in your system
locale-gen

clear
#ask the name of the user for create the user after
read -p "write the name of the user: " username

clear 
#add permissions for your user to use varios commands and others things
useradd -m -g users -G wheel,storage,power -s /bin/bash $username

clear
#ask for you define one password for your user (*this is very important don't forget it*)
echo "Create the user Password"
passwd $username

clear
#ask for you define one password for the root user *this is very important don't forget it*
echo "Create the Root Password"
passwd

clear
#install the sudo
pacman -Sy --noconfirm sudo


clear
echo "THIS STEP IS VERY IMPORTANT DONT MISS IT"
echo "you need to uncomment the string '%wheel ALL=(ALL:ALL) ALL'"
echo "the nano with the file that you need to change will be open in 7 secs"
sleep 7
nano /etc/sudoers

# install the Ethernet and Wifi necessary packages
pacman -Sy --noconfirm networkmanager dhcpcd dhcp
# make the Ethernet and Wifi necessary packages start with the system
systemctl enable NetworkManager
systemctl enable dhcpcd


clear
#download grub the system bootloader
pacman -S --noconfirm grub efibootmgr

clear 
#try to install the grub on your machine using the ufi method
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_btw --recheck

#try to generate the grub config
grub-mkconfig -o /boot/grub/grub.cfg

#uninstall nano, it have no more use
pacman -R --noconfirm nano

echo "All Done, Now you can say 'I use Arch BTW' :3"
