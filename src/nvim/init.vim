" TODO
" Add buffers to tabline
" Theming

" Plugins loading
call plug#begin('~/.local/share/nvim/plugged')
	
	" Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" VCS
	Plug 'mhinz/vim-signify'

	" Style
	Plug 'itchyny/lightline.vim'

call plug#end()

" CoC
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Lightline

" Signify

" Commands
command W w
command Q q

" Mappings
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


"	" Theming
"	call dein#add('chriskempson/base16-vim')
"	call dein#add('vim-airline/vim-airline')
"	call dein#add('vim-airline/vim-airline-themes')
"	" Utilities
"	call dein#add('ryanoasis/vim-devicons')
"	call dein#add('Townk/vim-autoclose')
"	" Autocompletion
"	call dein#add('dense-analysis/ale')
"	" VCS
"	call dein#add('mhinz/vim-signify')
"endif
"
"inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"imap <expr> <S-Tab> pumvisible() ?
"	\ "\<C-p>" :
"	\ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<S-Tab>"
"imap <expr> <CR>  pumvisible() ?
"	\ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<C-y>" :
"	\ "\<CR>"
"smap <expr><CR> neosnippet#expandable() ?
"	\ "\<Plug>(neosnippet_expand)" : "\<CR>"
"inoremap <expr> <Down> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
"inoremap <expr> <Up>  pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
"inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
"inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
