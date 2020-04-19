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
cp -fr ./src/nvim ~/.config

# git
cp -f ./src/git/gitconfig -T ~/.gitconfig	

# xorg
mkdir -p ~/.config/xorg
mkdir -p /etc/X11/xorg.conf.d
cp -f ./src/xorg/xinitrc -T ~/.xinitrc
cp -f ./src/xorg/Xresources -T ~/.config/xorg/Xresources
sudo cp -f ./src/xorg/40-libinput.conf -T /etc/X11/xorg.conf.d/40-libinput.conf
sudo cp -f ./src/xorg/20-modesetting.conf -T \
	/etc/X11/xorg.conf.d/20-modesetting.conf

# xdg
cp -f ./src/xdg/user-dirs.dirs -T ~/.config/user-dirs.dirs
cp -f ./src/xdg/user-dirs.locale -T ~/.config/user-dirs.locale

# awesome
cp -fr ./src/awesome ~/.config

# i3
cp -fr ./src/i3 ~/.config

# i3blocks
cp -fr ./src/i3blocks ~/.config

# polybar
cp -fr ./src/polybar ~/.config

# termite
cp -fr ./src/termite ~/.config

# rofi
cp -fr ./src/rofi ~/.config

# zathura
cp -fr ./src/zathura ~/.config

