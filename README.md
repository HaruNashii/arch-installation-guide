<details>
<summary>(Step 1) - Connecting to an Wi-Fi, if not connected via cable</summary>

> **if your Ethernet cable is connected, you can skip this step**

**1) you need to get your wifi device name, you can do it with the command:**
- "```iwctl station device list```"

**2) you need to make your wifi device scan for networks, you can do it with the command:**
- "```iwctl station your_wifi_device_name scan```"

**3) then you list the available networks, you can do it with the command:**
- "```iwctl station your_wifi_device_name get-networks```"

**4) connect to your desired network, you can do it with the command:**
- "```iwctl station your_wifi_device_name connect your_desired_network```"
  
</details>


<details>
<summary>(Step 2) - Driver Partitioning</summary>
  
> **for creating, deleting, changing types and changing size of partitions, i recommend you to use the command "```cfdisk your_device_name```"**

> **you can list your partitions and devices with the command "```lsblk```"**

> **your device name normally is smth like: "/dev/sdY", where "Y" is the letter of your device, (per example: your SSD may have the name "/dev/sda" and your HD may have the name "/dev/sdb")**

> **your partition name normally is smth like: "/dev/sdaX", where "X" is the number of the partition**

> **for the more basic installation you will need only 3 partitions, and the partitions is the followings:**
> - root
> - boot
> - Swap


**1) you need to create those 3 partitions with the correct type and enough size**
- root partition needs to have the "Linux Filesystem" type and the size i recommend atleast 20GB
- boot partition needs to have the "EFI System" type and the size i recommend 1GB
- swap partition needs to have the "Linux Swap" type and the size i recommend atleast 8GB


**2) after your create all partition with the correct type and with the necessary size, you need to format all partitions**
- root partition needs to be formatted with the "```mkfs.ext4 your_root_partition_name```" command
- boot partition needs to be formatted with the "```mkfs.fat -F 32 your_boot_partition_name```" command
- swap partition needs to be formatted with the "```mkswap your_swap_partition_name```" command

**3) after you create all necessary partitions, define the correct types and format everything, you need to mount those partition**
- root partition needs to be mounted in "/mnt", with the "```mount your_root_partition_name /mnt```" command
- boot partition needs to be mounted in "/mnt/boot/efi", but those folders doesn't exist yet, so you need to create them with the "```mkdir -p /mnt/boot/efi```" command and mount with with the "```mount your_boot_partition_name /mnt/boot/efi```" command
- swap partition needs to be ""turned on"" with the "```swapon your_swap_partition_name```" command

</details>



<details>
<summary>(Step 3) - Download the system</summary>

**1) you neeed to download all the necessary packages of the system in the mounted root partition, you can do it with the command:**
- "```pacstrap /mnt base linux linux-firmware```"

</details>



<details>
<summary>(Step 4) - Generate drives and partition config file, and Chroot</summary>

**1) you need to generate the fstab config file, you can do it with the command:**
   - "```genfstab -U -p /mnt >> /mnt/etc/fstab```"


**2) you need to enter your mounted root partition, you can do it with the command:**
   - "```arch-chroot /mnt```"

</details>



<details>
<summary>(Step 5) - Setting up your timezone and locale</summary>
  
> **you can list the available continents with "```ls /usr/share/zoneinfo/```"** command

> **you can list the available countries within in your continents with "```ls /usr/share/zoneinfo/your_continent/```"** command

  **1) you need to set your timezone, you can do it with the command:**
  - "```ln -sf /usr/share/zoneinfo/your_continent/your_country```"

  **2) then you need to sync your system with your defined timezone, you can do it with the command:**
  - "```hwclock --systohc```"
    
  **3) you will need to download a text editor to edit the locale config file, you can do it with the command:**
  - "```pacman -Sy nano```"
    
  **4) then you will need to edit the locale file, you will need to uncomment (remove the '#' from your desired locale), per example, if you want the US locale, you need to remove the '#' in the "en_US.UTF-8 UTF-8" line, also take note to uncommend the line that has the UTF-8 text, you can open the text editor with the following command:**
  - "```nano /etc/locale.gen```"
    
  **5) then you need to sync your system with your defined locale, you can do it with the command:**
  - "```locale-gen```"
</details>




<details>
<summary>(Step 6) - Setting up your user and root user</summary>

**1) you need to create your user, you can do it with the command: (remember to change "your_username", to your desired user name)**
- "```useradd -m -g users -G wheel,storage,power -s /bin/bash your_username```"

**2) you need set a password to your user with the command:**
- "```passwd your_username```"

**3) you need set a password to the root user with the command:**
- "```passwd```"

**4) you need to download the permission manager, you can do it with the command:**
- "```pacman -Sy sudo```"

**5) then you need to edit the users permissions config file ("/etc/sudoers"), you need to uncomment (remove the '#'), in the line "%wheel ALL=(ALL:ALL) ALL", you can do it with the command:**
- "```nano /etc/sudoers```" 

</details>




<details>
<summary>(Step 7) - Downloading Wifi/Ethernet managers</summary>

**1) for the entire support for wifi and ethernet support you need to install some packages, and you can do it with the command:**
- "```pacman -Sy networkmanager iwd dhcp dhcpcd"

**2) then you need to make it start with the system, you can do it with the command:**
- "```systemctl enable NetworkManager dhcpcd"

</details>




<details>
<summary>(Step 8) - Installing GRUB and generating the GRUB config file</summary>

**1) you need to download GRUB and efibootmgr, and you can do it with the command:**
- "```pacman -Sy --noconfirm grub efibootmgr```"

**2) then you need to start grub installation, you can do it with the command:**
- "```grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_BTW --recheck```"

**3) and to finish it, you need to generate the GRUB config file, you can do it with the command:**
- "```grub-mkconfig -o /boot/grub/grub.cfg```"

</details>




<details>
<summary>(Optional Step) - Install an Desktop Envinroment or an Window Manager</summary>

**option 1) Install GNOME and GDM, you can do it with the command:**
- "```pacman -Sy gnome gdm```"
then enable gdm to start when the system boot
- "```systemctl enable gdm```"

**option 2) Install KDE and SDDM, you can do it with the command:**
- "```pacman -Sy plasma-desktop sddm```"
then enable gdm to start when the system boot
- "```systemctl enable sddm```"

**option 3) Install Hyprland and SDDM, you can do it with the command:**
- "```pacman -Sy hyprland sddm```"
then enable gdm to start when the system boot
- "```systemctl enable sddm```"

</details>

GG, your Arch Linux is installed, now you can say "I use Arch BTW!!!!"

<details>
<summary>all commands used</summary>
  
- cfdisk
- mkfs.ext4 root_partition_name
- mkfs.fat -F 32 boot_partition_name
- mkswap swap_partition_name
- mount root_partition_name /mnt
- mkdir -p /mnt/boot/efi
- mount boot_partition_name /mnt/boot/efi
- swapon swap_partition_name
- pacstrap /mnt base linux linux-firmware
- genfstab -U -p /mnt >> /mnt/etc/fstab
- arch-chroot /mnt
- ln -sf /usr/share/zoneinfo/your_continent/your_time_zone /etc/localtime
- hwclock --systohc
- pacman -S nano
- nano /etc/locale.gen
- locale-gen
- useradd -m -g users -G wheel,storage,power -s /bin/bash your_username
- passwd your_username
- passwd
- pacman -S --noconfirm networkmanager dhcpcd dhcp
- systemctl enable NetworkManager dhcpcd
- nano /etc/sudoers
- pacman -S --noconfirm grub efibootmgr
- grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
- grub-mkconfig -o /boot/grub/grub.cfg

</details>

