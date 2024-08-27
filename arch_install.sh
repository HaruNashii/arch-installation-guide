#!/bin/bash

#add permission for the other scripts be executed
chmod a+x $PWD/arch_install_after_chroot.sh
chmod a+x $PWD/wifi_configuration.sh
chmod a+x $PWD/nvidia_sucks.sh

clear
read -p "What Device Will Be Your Boot Partition? :" bootpartition
#convert the boot partition to FAT32
mkfs.fat -F32 $bootpartition

clear
read -p "What Device Will Be Your Swap? :" swapdevice
#convert the swap partition to swap
mkswap $swapdevice

clear
read -p "What Device Will Be Your Root Partition? :" rootpartition


#-add an argument for the while be a loop
x=1
clear 
echo "What Filesystem Format You Will Use For The (Root Partition)"
echo "1 = ext4, 2 = btrfs"
read -p "asnwer : " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [1]*)
		    #convert the root partitiom in to ext4
		    mkfs.ext4 $rootpartition
		    clear
	            break
	            ;;
	        [2]*)
		    #convert the root partition in to btrfs
		    mkfs.btrfs -f $rootpartition
		    clear
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either '1' for (ext4) or '2' for (btrfs)."
		    read -p "asnwer : " answer
	            ;;
	    esac
done

#mount the "/" in /mnt
mount $rootpartition /mnt 

#create the boot folder in the "/" folder
mkdir /mnt/boot
mkdir /mnt/boot/efi

#mount the "boot" in /mnt/boot/efi
mount $bootpartition /mnt/boot/efi

#turn on the swap
swapon $swapdevice

#install the base of linux and others useful tools in the root of your system
pacstrap /mnt base linux linux-firmware nano

#generate the config of all your disks
genfstab -U -p /mnt >> /mnt/etc/fstab

#move scripts do the mounted system
mkdir /mnt/arch-install-help-for-my-friend
cp -rf $PWD/* /mnt/arch-install-help-for-my-friend/


clear
echo "Running Chroot..."
echo "Dont forget to run the 'arch_install_after_chroot.sh' script after the chroot"
sleep 3
clear
arch-chroot /mnt

