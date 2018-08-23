# Personal dotfiles

* __OS__ : [Archlinux](https://www.archlinux.org/)  
* __WM__ : [SwayWM](http://swaywm.org/)  
	With [i3blocks](https://github.com/vivien/i3blocks) as statusline for
	swaybar.
* __Term__ : [termite](https://github.com/thestinger/termite)  
	With homemade colorscheme, see in termite/config
* __Shell__ : Zsh  
	With [Anthigen](https://github.com/zsh-users/antigen) plugin manager
* __Editor__ : [NeoVim](https://github.com/neovim/neovim)  
	With [Vim-Plug](https://github.com/junegunn/vim-plug) plugin manager
* __File manager__ : [Ranger](http://ranger.github.io/)  
* __Font__ : DejaVu from [NerdFont](http://nerdfonts.com/) and
  [Terminus](http://terminus-font.sourceforge.net/) for tty
* __Launcher__ : [Rofi](https://github.com/DaveDavenport/rofi)  
* [__Wallpaper__](https://alpha.wallhaven.cc/wallpaper/30415)  


## How-to
Dotfiles come with a sync script to copy all the files in the proper folder to
avoid having hidden files in the git repo. To install the dotfiles to your
system, be careful to have required dependencies and run :

``` sh
git clone https://github.com/mat3ck/dotfiles.git
cd dotfiles
./sync.sh
```


## Details and dependencies

### Dependencies
Common : `git`, `NerdFont`  
Sway : `i3blocks`  
Zsh : `antigen`  
NeoVim : `Vim-Plug`, `pip` and neovim support (see
[deoplete](https://github.com/Shougo/deoplete.nvim))  
Ranger : `libcaca` for ascii preview of images  

See each plugin doc for more information.

### Sway
Config files are split to ease theme managing. The wallpaper is put in the theme
folder. I use swaybar as a status bar with i3blocks, and have a personnal
version of the wifi block in this repo to change few colors.

### Termite
Custom config with custom colorscheme. See the colorscheme section for more
information on it.

### Zsh
`~/.zshenv` set `$ZDOTDIR` to `~/.config/zsh`.  
`.zprofile` contains environments variables and lauches sway.  
`.zshrc` uses Anthigen plugins manager to bundle `git`, `pip`,
`zsh-syntax-highlighting`, `zsh-autosuggestions` and `agnoster` theme (requires
powerline patched font) in addition to some custom settings.

### NeoVim
Neovim with Vim-Plug plugins manager. I use base16-default-dark colorscheme with
overwritten settings to use my homemade colorscheme set in termite config, same
for airline.

### Ranger
Custom config with imv added as image viewer. Image previews with w3m is not
enabled since it doesn't work well in termite, it is done with img2txt instead
(requires libcaca).

### Other
Rofi isn't customized and require mouse input to get focus in wayland (see [this
issue](https://github.com/swaywm/sway/issues/267))

## Colorscheme

The colorscheme is built from scratch using the wallpaper background `1A181D` as
main dark hue. See sources bellow to get more information on how to build a
colorscheme. This colorscheme is used in neovim and airline through default
base16 themes.

``` sh
# Foreground
foreground = `#e5e4ce`
foreground_bold = `#fffff2`
# Background
background = `#2e2a33`
# Cursor
cursor = `#e5e4ce`
cursor_foreground = `#2e2a33`

# Black
color0 = `#2e2a33`
color8 = `#504a59`
# Red
color1 = `#bf303c`
color9 = `#bf303c`
# Green
color2 = `#7bbf30`
color10 = `#7bbf30`
# Yellow
color3 = `#bfbf30`
color11 = `#bfbf30`
# Blue
color4 = `#3060bf`
color12 = `#3660bf`
# Purple
color5 = `#a730bf`
color13 = `#a730bf`
# Teal
color6 = `#bf5f30`
color14 = `#bf5f30`
# White
color7 = `#e5e4ce`
color15 = `#e5e4ce`
```

[How to create a colorscheme](https://designmodo.com/create-color-scheme/)  
[Adobe Color CC](https://color.adobe.com/create/color-wheel/)  

