#!/bin/bash
 
#change the system settings of the timezone to Brazil Sao Paulo :)
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
#syncronize the timezone settings with the system
hwclock --systohc

clear 
echo "Check If The Time And Date Is Correct"
date

sleep 8
clear
#open the nano editor for you select your system language
nano /etc/locale.gen
#apply the locale.gen config in your system
locale-gen

#change the name of the host for "blake"
clear
read -p "write the name of the user: " username
hostnamectl set-hostname $username
clear 
echo "Create the Root Password"
passwd

#add permissions for your user "blake" to use varios commands and others things
useradd -m -g users -G wheel,storage,power -s /bin/bash $username
clear
echo "Create the user Password"
passwd $username

#download useful packages that will help you and grub the system bootloader
pacman -S os-prober networkmanager grub efibootmgr

clear 
echo "Its Time My Friend, Its Time For The GRUB INSTALLLL"
sleep 2 
echo "so... that the fight begins"
#try to install the grub on your machine using the ufi method
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
#try to generate the grub config
grub-mkconfig -o /boot/grub/grub.cfg
