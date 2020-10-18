# Personal dotfiles

* __OS__ : [Archlinux](https://www.archlinux.org/)
* __WM__ : [Sway](https://swaywm.org/)
* __Status line__ : [Waybar](https://github.com/Alexays/Waybar)
* __Lock Screen__ : [Swaylock-effects](https://github.com/mortie/swaylock-effects)
* __Terminal__ : [Alacritty](https://github.com/alacritty/alacritty)
* __Shell__ : [zsh](https://www.zsh.org/)
  [Zinit](https://github.com/zdharma/zinit) plugin manager and
  [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
* __Editor__ : [NeoVim](https://github.com/neovim/neovim) with
  [vim-plug](https://github.com/junegunn/vim-plug) plugin manager
* __File manager__ : [Ranger](http://ranger.github.io/)
* __Font__ : DejaVu from [NerdFont](http://nerdfonts.com/)
* __Launcher__ : [Rofi](https://github.com/DaveDavenport/rofi)
* __Wallpaper__: Custom BASE00 from base16-material with HSV noise
* __THEME__: [Base16 Material Theme](https://github.com/ntpeters/base16-materialtheme-scheme)


# Preview
![](https://i.imgur.com/3CYGvvs.jpg)
![](https://i.imgur.com/HD9JF6k.jpg)


# How-to
Dotfiles come with a sync script to copy all the files in the proper folder to
avoid having hidden files in the git repo. To install the dotfiles to your
system, be careful to have required dependencies and run:

``` sh
git clone https://github.com/mat3ck/dotfiles.git
cd dotfiles
./sync.sh
```
