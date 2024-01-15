#!/bin/bash 

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

clear 
echo "Check If The Time And Date Is Correct"
date

sleep 8
clear
nano /etc/locale.gen
locale-gen

hostnamectl set-hostname blake
clear 
echo "Create the Root Password"
passwd

useradd -m -g users -G wheel,storage,power -s /bin/bash blake
echo "Create the user Password"
passwd blake

pacman -S os-prober network-manager-applet networkmanager grub efibootmgr

clear 
echo "Its Time My Friend, Its Time For The GRUB INSTALLLL"
sleep 2 
echo "so... that the fight begins"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg
