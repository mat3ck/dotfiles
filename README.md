# Personal dotfiles

* __OS__ : [Archlinux](https://www.archlinux.org/)  
* __WM__ : [SwayWM](http://swaywm.org/)  
	With [i3blocks](https://github.com/vivien/i3blocks) as statusline for
	swaybar.
* __Term__ : [termite](https://github.com/thestinger/termite)  
	With homemade colorscheme, see in termite/config
* __Shell__ : Zsh
	With [Anthigen](https://github.com/zsh-users/antigen) plugin manager
* __File manager__ : [ranger](http://ranger.github.io/)  
* __Editor__ : [NeoVim](https://github.com/neovim/neovim)  
	With [Vim-Plug](https://github.com/junegunn/vim-plug) plugin manager
* __Launcher__ : [Rofi](https://github.com/DaveDavenport/rofi)  
* [__Wallpaper__](https://alpha.wallhaven.cc/wallpaper/30415)  

## Details and requirements

## How-to
Dotfiles come with a sync script to copy all the files in the proper folder to
avoid hidden files in the git repo. To install the dotfiles to your system, just
do :

```
git clone https://github.com/mat3ck/dotfiles.git
cd dotfiles
./sync.sh
```


