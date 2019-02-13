### Just a little script to sync this folder with system dotfiles

# zsh
cp -fv ./zshenv -T ~/.zshenv
cp -fv ./config/zsh/zshrc -T ~/.config/zsh/.zshrc
cp -fv ./config/zsh/zprofile -T ~/.config/zsh/.zprofile

# i3
cp -frv ./config/i3 ~/.config

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

# neovim
cp -frv ./config/nvim ~/.config
