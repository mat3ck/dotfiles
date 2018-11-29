set runtimepath+=~/usr/share/vim/vimfiles/autoload/dein.vim

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')
	call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
	" Theming
	call dein#add('chriskempson/base16-vim')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	" Utilities
	call dein#add('scrooloose/nerdtree')
	call dein#add('ryanoasis/vim-devicons')
	call dein#add('Townk/vim-autoclose')
	" Autocompletion
	call dein#add('Shougo/deoplete.nvim')
	" VCS
	call dein#add('mhinz/vim-signify')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#end()
	call dein#save_state()
endif

" Colorscheme
colorscheme base16-default-dark
highlight LineNr cterm=bold ctermbg=0 ctermfg=8
highlight SignColumn cterm=bold ctermbg=0 ctermfg=8
highlight ColorColumn ctermbg=8 ctermfg=8
highlight VertSplit ctermbg=8 ctermfg=8
highlight Error ctermbg=9 ctermfg=0
highlight ErrorMsg ctermbg=9 ctermfg=0
highlight StatusLine cterm=bold ctermbg=8 ctermfg=10
highlight WildMenu cterm=bold ctermbg=10 ctermfg=8
highlight IncSearch ctermbg=14 ctermfg=0
highlight Search ctermbg=11 ctermfg=0
highlight Substitute ctermbg=11 ctermfg=0
highlight Todo cterm=bold ctermbg=10 ctermfg=8

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16color'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Signify
highlight SignifySignAdd cterm=bold ctermbg=0 ctermfg=10
highlight SignifySignDelete cterm=bold ctermbg=0 ctermfg=9
highlight SignifySignChange cterm=bold ctermbg=0 ctermfg=12

" Deoplete
let g:deoplete#enable_at_startup = 1
highlight Pmenu ctermbg=8 ctermfg=10
highlight PmenuSel ctermbg=10 ctermfg=8
highlight PmenuSbar ctermbg=10 ctermfg=8
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Autoclose
let g:AutoClosePreserveDotReg = 0

" Neovim
set number
set signcolumn=yes
set colorcolumn=81
set textwidth=80
set nowrap
set scrolloff=8

set list
set listchars=tab:\ \ ,trail:$

set showmatch

set tabstop=8
set shiftwidth=8
set smartindent
set noexpandtab
