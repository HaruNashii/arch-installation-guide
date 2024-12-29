#!/bin/bash



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
#convert the root partitiom in to ext4
mkfs.ext4 $rootpartition

#mount the root partition in /mnt
mount $rootpartition /mnt 

#create the boot folder in the "/" folder
mkdir -p /mnt/boot/efi

#mount the boot partition in /mnt/boot/efi
mount $bootpartition /mnt/boot/efi

#turn on the swap
swapon $swapdevice

#install the base of linux in the root of your system
pacstrap /mnt base linux linux-firmware

#generate the config file of all your disks
genfstab -U -p /mnt >> /mnt/etc/fstab

#add permission for the other scripts be executed
chmod a+x $PWD/arch_install_after_chroot.sh
chmod a+x $PWD/nvidia_sucks.sh

#copy scripts do the mounted system
mkdir /mnt/arch-install-help-for-my-friend
cp -rf $PWD/* /mnt/arch-install-help-for-my-friend/

clear
echo "Running Chroot..."
echo "Dont forget to run the 'arch_install_after_chroot.sh' script after the chroot"
sleep 3
clear
arch-chroot /mnt

