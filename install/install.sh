# Kernel parameters
#   GRUB_CMDLINE_LINUX_DEFAULT=
#       mem_sleep_default=deep
#       resume=UUID=...
#       resume_offset=...
#   GRUB_CMDLINE_LINUX=
#       cryptdevice=UUID=...:abc
#       root=/dev/mapper/abc

# mkinitcpio hooks
#   keyboard
#   encrypt
#   resume

# User management
usermod -a -G video $USER
#   add wheel group to sudo

# Decrease swapiness
echo "vm.swappiness=10" > /etc/sysctl.d/99-swappiness.conf

# Firmware
systemctl enable fwupd.service

# Audio
systemctl enable --user pipewire-pulse.service

# Network
timedatectl set-ntp true
systemctl enable NetworkManager
systemctl enable bluetooth.service
sed -i -e 's/.*AutoEnable=false/AutoEnable=true/' /etc/bluetooth/main.conf

# Pacman
#   add multilib
rankmirrors /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
sed -i -e 's/#Color/Color/' /etc/pacman.conf

# Zinit install
mkdir -p ~/bin/zinit
git clone https://github.com/zdharma/zinit.git ~/bin/zinit

# Cargo setup
rustup toolchain install stable

# Zephyr
mkdir -p ~/bin/zephyr
cd ~/bin/zephyr
west init
west update
west zephyr-export
pip install --user -r ~/zephyrproject/zephyr/scripts/requirements.txt
cd ~/bin
wget -P /tmp https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.14.1/zephyr-sdk-0.14.1_linux-x86_64.tar.gz
wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.14.1/sha256.sum | shasum --check --ignore-missing
tar xvf /tmp/zephyr-sdk-0.14.1_linux-x86_64.tar.gz
cd ~/bin/zephyr-sdk-0.14.1
./setup.sh

