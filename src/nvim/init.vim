" TODO
" Add denite and defx

" dein installed at /usr/share/vim/vimfiles/autoload/dein.vim

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')
	" Theming
	call dein#add('chriskempson/base16-vim')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	" Utilities
	call dein#add('ryanoasis/vim-devicons')
	call dein#add('Townk/vim-autoclose')
	call dein#add('Shougo/defx.nvim')
	" call dein#add('Shougo/denite.nvim')
	" Autocompletion
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('Shougo/deoplete-clangx')
	call dein#add('Shougo/neoinclude.vim')
	call dein#add('dense-analysis/ale')
	" VCS
	call dein#add('mhinz/vim-signify')
	" Remote plugins
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#end()
	call dein#save_state()
endif

" Colorscheme
set termguicolors
let base16colorspace=256
colorscheme base16-nord

" Airline
let g:airline_theme = 'base16_nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Signify
let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
let g:signify_realtime = 0

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('auto_complete_start_length ', 1)
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#option('sources',	{ '_': ['buffer', 'file','neosnippet', 'clangx'],
										\ 'python': ['buffer', 'file', 'neosnippet'],
										\ })
call deoplete#custom#source('buffer', 'rank', 10)
call deoplete#custom#source('file', 'rank', 05)
call deoplete#custom#source('neosnippet', 'rank', 07)
call deoplete#custom#source('clangx', 'rank', 09)
call deoplete#custom#option('require_same_filetype', v:false)

call deoplete#custom#var('clangx', 'clang_binary', '/usr/local/bin/clang')
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')

inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ?
	\ "\<C-p>" :
	\ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<S-Tab>"
imap <expr> <CR>  pumvisible() ?
	\ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<C-y>" :
	\ "\<CR>"
smap <expr><CR> neosnippet#expandable() ?
	\ "\<Plug>(neosnippet_expand)" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
inoremap <expr> <Up>  pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Neosnippet
"imap <expr> <S-Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<S-Tab>"
"smap <expr> <S-Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<S-Tab>"
"xmap <expr> <S-Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<S-Tab>"

" Autoclose
let g:AutoClosePreserveDotReg = 0

" Neovim
command W w
command Q q

nnoremap ; :

map <silent> // :nohlsearch <CR>
map <silent> <A-right> :bnext! <CR>
map <silent> <A-left> :bprev! <CR>
map <silent> gb :bnext! <CR>
map <silent> gB :bprev! <CR>
map <silent> {i}gB :buffer {i}! <CR>

set number
set signcolumn=yes
set textwidth=79
set nowrap
set colorcolumn=80
set scrolloff=8
set wildmenu

set tabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set list
set listchars=tab:\ \ ,trail:$,extends:#
set showmatch
set smartcase

" C options
autocmd FileType c set cindent

" C++ options
autocmd FileType cpp set cindent

" Python options
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal smarttab
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal copyindent
autocmd FileType python setlocal smartindent
