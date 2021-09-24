
" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '
                \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
        \| endif

" Plugins loading
call plug#begin('~/.local/share/nvim/plugged')
	
	" Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" VCS
	Plug 'mhinz/vim-signify'

	" Style
	Plug 'chriskempson/base16-vim'
	" Plug 'itchyny/lightline.vim'
    " Plug 'mengelbrecht/lightline-bufferline'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()


" CoC
let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-html',
            \ 'coc-jedi',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-rust-analyzer',
            \ 'coc-sh',
            \ 'coc-snippets',
            \ 'coc-vimlsp',
            \ 'coc-yaml'
            \]
inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
if exists('*complete_info')
    inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" Signify


" Base16
let base16colorspace=256
colorscheme base16-material


" Vim-Airline
let g:airline_theme = 'base16_material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" Commands and Mappings
command W w
command Q q
nnoremap ; :
map <silent> // :nohlsearch <CR>
map <silent> gb :bnext! <CR>
map <silent> gB :bprev! <CR>
map <silent> {i}gB :buffer {i}! <CR>


" Refresh
set updatetime=200


" Info ui
set number
set signcolumn=yes
set showtabline=2
set wildmenu
set noshowmode
set list
set listchars=tab:\ \ ,trail:$,extends:#
set showmatch
set scrolloff=4


" Indent and textwidth
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on
set textwidth=80
set colorcolumn=+1


" Searching
set ignorecase
set smartcase


" Misc
set hidden


" Filetypes
au BufRead,BufNewFile *.vh set filetype=verilog
