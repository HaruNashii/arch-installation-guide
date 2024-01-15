#!/bin/bash


#convert the /dev/sda1 in to FAT32
mkfs.fat -F32 /dev/sda1
#convert the /dev/sda2 to be the swap
mkswap /dev/sda2
#convert the /dev/sda3 in to ext4
mkfs.ext4 /dev/sda3 
#convert the /dev/sda4 in to ext4
mkfs.ext4 /dev/sda4

#mount the "/" of /dev/sda3 in /mnt
mount /dev/sda3 /mnt 
#create the home folder in the / folder of the /dev/sda3
mkdir /mnt/home
#create the boot folder in the / folder of the /dev/sda3
mkdir /mnt/boot/efi
#mount the "/home" of /dev/sda4 in /mnt
mount /dev/sda4 /mnt/home
#mount the "/boot" of /dev/sda1 in /mnt
mount /dev/sda1 /mnt/boot/efi
#turn on the swap
swapon /dev/sda2

clear
echo "check if everything is correctly mounted"
lsblk
sleep 6
clear 

nano /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd
#generate the config of the disks
genfstab -U -p /mnt >> /mnt/etc/fstab

clear 
echo "check if the fstab is correct (should have all /dev/sda(1,2,3,4)"
cat /mnt/etc/fstab
sleep 5

clear
echo "Changing to the /dev/sda3/ disk, bye :)"
echo "be sure to run the other script (arch_install_after_chroot.sh)"
sleep 3
clear
arch-chroot /mnt
