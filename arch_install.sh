#!/bin/bash

#add permission for the other scripts be executed
chmod a+x $PWD/arch_install_after_chroot.sh
chmod a+x $PWD/wifi_configuration.sh

#convert the /dev/sda1 in to FAT32
mkfs.fat -F32 /dev/sda1
#convert the /dev/sda2 to be the swap
mkswap /dev/sda2

#-add an argument for the while be a loop
x=1
clear 
echo "What Filesystem Format You Will Use For '/' (/dev/sda3) and '/home' (/dev/sda4)"
echo "1 = ext4, 2 = btrfs"
read -p "asnwer : " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [1]*)
		    #convert the /dev/sda3 in to ext4
		    mkfs.ext4 /dev/sda3 
		    #convert the /dev/sda4 in to ext4
		    mkfs.ext4 /dev/sda4
	            break
	            ;;
	        [2]*)
		    #convert the /dev/sda3 in to btrfs
		    mkfs.btrfs -f /dev/sda3 	
		    #convert the /dev/sda4 in to btrfs
		    mkfs.btrfs -f /dev/sda4
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either '1' for (ext4) or '2' for (btrfs)."
		    read -p "asnwer : " answer
	            ;;
	    esac
done


#mount the "/" of /dev/sda3 in /mnt
mount /dev/sda3 /mnt 
#create the boot folder in the / folder of the /dev/sda3
mkdir /mnt/boot
mkdir /mnt/boot/efi
#mount the "/boot" of /dev/sda1 in /mnt
mount /dev/sda1 /mnt/boot/efi
#create the home folder in the / folder of the /dev/sda3
mkdir /mnt/home
#mount the "/home" of /dev/sda4 in /mnt
mount /dev/sda4 /mnt/home
#turn on the swap
swapon /dev/sda2

clear
echo "check if everything is correctly mounted"
lsblk
sleep 6


clear 
echo "check if the mirrorlist is correct"
sleep 3
nano /etc/pacman.d/mirrorlist

#install the base of linux and others useful tools in the /dev/sda3 the root of your system
pacstrap /mnt base linux linux-firmware

#generate the config of all your disks
genfstab -U -p /mnt >> /mnt/etc/fstab


clear 
echo "check if the fstab is correct (should have all /dev/sda(1,2,3,4)"
sleep 2
cat /mnt/etc/fstab
sleep 5



clear
echo "Changing to the /dev/sda3/ disk, bye :)"
echo "be sure to run the other script (arch_install_after_chroot.sh)"
sleep 3
clear
arch-chroot /mnt
