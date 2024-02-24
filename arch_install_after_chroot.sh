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

clear
#ask the name of the user for create the user after
read -p "write the name of the user: " username
clear 

#add permissions for your user to use varios commands and others things
useradd -m -g users -G wheel,storage,power -s /bin/bash $username
clear
#ask for you define one password for your user *this is very important don't forget it*
echo "Create the user Password"
passwd $username

clear
#ask for you define one password for the root user *this is very important don't forget it*
echo "Create the Root Password"
passwd

clear
#install the sudo
pacman -Sy --noconfirm sudo




#-add an argument for the while be a loop
x=1
clear
echo "you will use internet via Ethernet or Wi-Fi"
echo "1 = Ethernet, 2 = Wi-Fi"
read -p "asnwer : " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [1]*)
             pacman -S --noconfirm networkmanager dhcpcd dhcp
             systemctl enable NetworkManager
             systemctl enable dhcp
             systemctl enable dhcpcd
	            break
	            ;;
	        [2]*)
	            pacman -S --noconfirm iwd dhcpcd dhcp
             systemctl enable dhcp
             systemctl enable dhcpcd
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either '1' for (Ethernet) or '2' for (Wi-Fi)."
		    read -p "asnwer : " answer
	            ;;
	    esac
done







clear
echo "THIS STEP IS VERY IMPORTANT DONT MISS IT"
echo "you need to uncomment the string '%wheel ALL=(ALL:ALL) ALL'"
echo "the nano with the file that you need to change will be open in 7 secs"
sleep 7
nano /etc/sudoers



#-add an argument for the while be a loop
x=1
clear
echo "Choose Your BootLoader"
read -p "('1' = GRUB, '2'=SYSTEMD-BOOT): " answer_two
while [ $x -le 2 ]; do

            case $answer_two in
                [1]*)
                    clear
                    #download grub the system bootloader
                    pacman -S --noconfirm grub efibootmgr

clear 
echo "Installing GRUB"
sleep 2 
#try to install the grub on your machine using the ufi method
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
#try to generate the grub config
grub-mkconfig -o /boot/grub/grub.cfg
sleep 3
                    break
                    ;;
                [2]*)
                    clear
                    #install the systemd-boot bootloader
                    bootctl install
                    break
                    ;;
                *)
                    echo "Invalid input. Please enter either 'Y' or 'N'."
                    read -p "asnwer : " answer_two
                    ;;
            esac
done








#download and install the pipewire, and remove the pulseaudio
sudo pacman -Rdd pulseaudio
sudo pacman -Sy --needed --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber

#change the active user to the created user
su $username

#active the pipewire service and exclude the pulseaudio service
systemctl --user daemon-reload
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user mask pulseaudio
systemctl --user --now enable pipewire pipewire-pulse

#go back to the installation normal user (root)
su root

#-add an argument for the while be a loop
x=1
echo "You Want To Install Hyprland?"
read -p "('Y' or 'N'): " answer_two
while [ $x -le 2 ]; do

	    case $answer_two in
	        [Yy]*)
		    clear
		    ./hyprland_install.sh
	            break
	            ;;
	        [Nn]*)
		    clear
		    echo "Ok, Nothing More To Do."
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either 'Y' or 'N'."
		    read -p "asnwer : " answer_two
	            ;;
	    esac
done
