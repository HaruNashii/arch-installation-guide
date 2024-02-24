#!/bin/bash


#-add an argument for the while be a loop
x=1
clear 
echo "You Want The Hyprland With The Following Utilities : (waybar, Grim, wl_clipboard, wofi, hyprpaper)?"
read -p "('Y' or 'N'): " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [Yy]*)
			clear
			echo "If The Option Of Fonts Appear, I Recommend Your Select The Second 'notosans'"
			pacman -S hyprland sddm kitty hyprpaper wofi grim wl-clipboard
	            break
	            ;;
	        [Nn]*)
			clear
			echo "If The Option Of Fonts Appear, I Recommend Your Select The Second 'notosans'"
			pacman -S hyprland sddm kitty
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either 'Y' or 'N'"
		    read -p "asnwer : " answer
	            ;;
	    esac
done

#-add an argument for the while be a loop
x=1
clear 
echo "You Want To Install My Dotfiles?"
read -p "('Y' or 'N'): " answer
while [ $x -le 2 ]; do

	    case $answer in
	        [Yy]*)
			if [ -f "$PWD/rice.sh" ]; then
				./rice.shnt
			else
				cd $PWD/arch-install-help-for-my-friend
    				./rice.sh
   			fi
      			pacman -R kitty
	            break
	            ;;
	        [Nn]*)
	            break
	            ;;
	        *)
		    echo "Invalid input. Please enter either 'Y' or 'N'"
		    read -p "asnwer : " answer
	            ;;
	    esac
done

# enable the login manager
systemctl enable sddm
