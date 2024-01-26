#!/bin/bash


x=1
clear 
echo "This Script Most Be Runned Only After The System Is Completed Downloaded."
read -p "You Are Sure That You Want To Continue? ('Y' or 'N')" answer
while [ $x -le 2 ]; do

	    case $answer in
	        [Yy]*)
clear
sudo pacman -S --noconfirm iwd networkmanager dhcpcd

#enable the network modules to start with the system
systemctl enable iwd
systemctl enable NetworkManager
systemctl enable systemd-networkd
systemctl enable dhcpcd

#start the network modules
systemctl start iwd
systemctl start NetworkManager
systemctl start systemd-networkd
systemctl start dhcpcd

#configure your ip adress
dhcpcd

#configure your network host name
clear
read -p "Select The Name of the network host" hostname
sudo hostnamectl set-hostname $hostname


#list the available devices that connect with the wifi
clear
iwctl station list

read -p "Write The Name Of The Device Above: " devicename
clear
#make one scan for networks close to you
iwctl station $devicename scan
#list the available networks close to you
iwctl station $devicename get-networks
read -p "Select The Name Of Your Wi-Fi" wifiname
#connect to the network
iwctl station $devicename connect $wifiname

#configure your ip adress
dhcpcd

clear
#show if the device is connected in the network
iwctl station $devicename show

echo " "
echo "Done."

	            break
	            ;;
	        [Nn]*)
		    echo "Ok, Nothing To Do."
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either 'Y' or 'N'"
		    read -p "asnwer : " answer
	            ;;
	    esac
done
