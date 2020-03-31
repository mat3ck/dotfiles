### Just a little script to sync this folder with system dotfiles

# zsh
mkdir -p ~/.config/zsh
cp -fv ./src/zsh/zshenv -T ~/.zshenv
cp -fv ./src/zsh/zshrc -T ~/.config/zsh/.zshrc
cp -fv ./src/zsh/zprofile -T ~/.config/zsh/.zprofile

# xorg
mkdir -p ~/.config/xorg
cp -fv ./src/xorg/xinitrc -T ~/.xinitrc
cp -fv ./src/xorg/Xresources -T ~/.config/xorg/Xresources

# yay
cp -frv ./src/yay ~/.config

# awesome
cp -frv ./src/awesome ~/.config

# i3
cp -frv ./src/i3 ~/.config

# i3blocks
cp -frv ./src/i3blocks ~/.config

# polybar
cp -frv ./src/polybar ~/.config

# termite
cp -frv ./src/termite ~/.config

# ranger
cp -frv ./src/ranger ~/.config

# rofi
cp -frv ./src/rofi ~/.config

# neovim
cp -frv ./src/nvim ~/.config

# xdg
cp -fv ./src/xdg/user-dirs.dirs -T ~/.config/user-dirs.dirs
cp -fv ./src/xdg/user-dirs.locale -T ~/.config/user-dirs.locale

# git
cp -fv ./src/git/gitconfig -T ~/.gitconfig	
