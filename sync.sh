### Just a little script to sync this folder with system dotfiles

# udev
sudo cp -fr ./src/udev /etc

# yay
cp -fr ./src/yay ~/.config

# zsh
mkdir -p ~/.config/zsh
cp -f ./src/zsh/zshenv -T ~/.zshenv
cp -f ./src/zsh/zshrc -T ~/.config/zsh/.zshrc
cp -f ./src/zsh/zprofile -T ~/.config/zsh/.zprofile
cp -f ./src/zsh/p10k.zsh -T ~/.config/zsh/.p10k.zsh

# ranger
cp -fr ./src/ranger ~/.config

# neovim
mkdir -p ~/.config/nvim
mkdir -p ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes
cp -fr ./src/nvim/init.vim ~/.config/nvim
cp -fr ./src/nvim/coc-settings.json ~/.config/nvim
cp -fr ./src/nvim/svls.toml ~/.svls.toml
cp -fr ./src/nvim/svlint.toml ~/.svlint.toml
cp -f ./src/nvim/base16_material.vim -T \
    ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/base16_material.vim

# git
cp -f ./src/git/gitconfig -T ~/.gitconfig	

# wayland
cp -fr ./src/environment.d ~/.config

# xorg
mkdir -p ~/.config/xorg
sudo mkdir -p /etc/X11/xorg.conf.d
cp -f ./src/xorg/xinitrc -T ~/.xinitrc
cp -f ./src/xorg/Xresources -T ~/.config/xorg/Xresources
sudo cp -f ./src/xorg/40-libinput.conf -T /etc/X11/xorg.conf.d/40-libinput.conf
#sudo cp -f ./src/xorg/20-modesetting.conf -T \
#	/etc/X11/xorg.conf.d/20-modesetting.conf

# xdg
cp -f ./src/xdg/user-dirs.dirs -T ~/.config/user-dirs.dirs
cp -f ./src/xdg/user-dirs.locale -T ~/.config/user-dirs.locale

# awesome
cp -fr ./src/awesome ~/.config

# sway
cp -fr ./src/sway ~/.config

# i3
cp -fr ./src/i3 ~/.config

# waybar
cp -fr ./src/waybar ~/.config

# i3blocks
cp -fr ./src/i3blocks ~/.config

# polybar
cp -fr ./src/polybar ~/.config

# alacritty
cp -fr ./src/alacritty ~/.config

# termite
cp -fr ./src/termite ~/.config

# rofi
cp -fr ./src/rofi ~/.config

# wofi
cp -fr ./src/wofi ~/.config

# gtk2
cp -fr ./src/gtk-2.0 ~/.config

# gtk3
cp -fr ./src/gtk-3.0 ~/.config

# zathura
cp -fr ./src/zathura ~/.config

# ssh
cp -f ./src/ssh/config ~/.ssh/config

