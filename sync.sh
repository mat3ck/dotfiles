### Just a little script to sync this folder with system dotfiles

# zsh
cp -fv ./zshenv ~/.zshenv
cp -frv ./config/zsh ~/.config
mv -fv ~/.config/zsh/zprofile ~/.config/zsh/.zprofile
mv -fv ~/.config/zsh/zshrc ~/.config/zsh/.zshrc

# sway
cp -frv ./config/sway ~/.config

# i3blocks
cp -frv ./config/i3blocks ~/.config

# termite
cp -frv ./config/termite ~/.config

# ranger
cp -frv ./config/ranger ~/.config

# rofi
cp -frv ./config/rofi ~/.config

# antigen
cp -frv ./config/antigen ~/.config
