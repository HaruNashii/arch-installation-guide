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
#ask for you define one password for the root user *this is very important don't forget it*
echo "Create the Root Password"
passwd

#add permissions for your user to use varios commands and others things
useradd -m -g users -G wheel,storage,power -s /bin/bash $username
clear
#ask for you define one password for your user *this is very important don't forget it*
echo "Create the user Password"
passwd $username


#-add an argument for the while be a loop
x=1
echo "you will use internet via Ethernet or Wi-Fi"
echo "1 = Ethernet, 2 = Wi-Fi"
read -p "asnwer : " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [1]*)
             pacman -S networkmanager dhcpcd
	            break
	            ;;
	        [2]*)
	            pacman -S iwd networkmanager dhcpcd
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either '1' for (Ethernet) or '2' for (Wi-Fi)."
		    read -p "asnwer : " answer
	            ;;
	    esac
done


#download grub the system bootloader
pacman -S grub efibootmgr


clear 
echo "Its Time My Friend, Its Time For The GRUB INSTALLLL"
sleep 2 
echo "so... that the fight begins"
#try to install the grub on your machine using the ufi method
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
#try to generate the grub config
grub-mkconfig -o /boot/grub/grub.cfg



echo "i will not make code for see if the grub give error or not, but if its not give an error, good luck installing one DE/WM/GUI, i will not help with that"
