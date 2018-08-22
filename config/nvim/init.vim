call plug#begin('~/.local/share/nvim/plugged')

" Theming
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Utilities
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Townk/vim-autoclose'
" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" VCS
Plug 'mhinz/vim-signify'

call plug#end()


" Vim-Plug
let g:plug_window = 'vertical topleft tabnew'

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
set wrap
set scrolloff=8

set list
set listchars=tab:\ \ ,trail:$

set showmatch

set tabstop=8
set shiftwidth=8
set smartindent
set noexpandtab
