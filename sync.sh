# Just a little script to sync this folder with system dotfiles

# zsh
cp -fv ./zshenv ~/.zshenv
cp -fv ./config/zsh/zprofile ~/.config/zsh/.zprofile
cp -fv ./config/zsh/zshrc ~/.config/zsh/.zshrc

# termite
cp -frv ./config/termite ~/.config

# sway
cp -frv ./config/sway ~/.config
