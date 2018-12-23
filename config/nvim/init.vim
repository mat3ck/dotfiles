" TODO
" Add denite and defx
" Complete deoplete config with jedi and clang_complete support

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
	call dein#add('Shougo/denite.nvim')
	" Autocompletion
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('zchee/deoplete-jedi')
	" VCS
	call dein#add('mhinz/vim-signify')
	call dein#add('roxma/nvim-yarp')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#end()
	call dein#save_state()
endif

" Colorscheme
colorscheme base16-default-dark
function! s:base16_customize() abort
	" General
	call Base16hi("LineNr", "", "", g:base16_cterm03, g:base16_cterm00, "bold", "")
	call Base16hi("SignColumn", "", "", g:base16_cterm03, g:base16_cterm00, "bold", "")
	call Base16hi("ColorColumn", "", "", "", g:base16_cterm03, "", "")
	call Base16hi("VertSplit", "", "", g:base16_cterm03, g:base16_cterm00, "", "")
	call Base16hi("Error", "", "", g:base16_cterm00, g:base16_cterm09, "", "")
	call Base16hi("ErrorMsg", "", "", g:base16_cterm00, g:base16_cterm09, "", "")
	call Base16hi("StatusLine", "", "", g:base16_cterm0B, g:base16_cterm03, "bold", "")
	call Base16hi("WildMenu", "", "", g:base16_cterm03, g:base16_cterm0B, "bold", "")
	call Base16hi("Search", "", "", g:base16_cterm00, g:base16_cterm0A, "", "")
	call Base16hi("IncSearch", "", "", g:base16_cterm00, g:base16_cterm0A, "", "")
	call Base16hi("Substitute", "", "", g:base16_cterm00, g:base16_cterm0F, "", "")
	call Base16hi("Todo", "", "", g:base16_cterm03, g:base16_cterm0F, "bold", "")
	" Signify
	call Base16hi("SignifySignAdd", "", "", g:base16_cterm0B, g:base16_cterm00, "bold", "")
	call Base16hi("SignifySignDelete", "", "", g:base16_cterm09, g:base16_cterm00, "bold", "")
	call Base16hi("SignifySignChange", "", "", g:base16_cterm0D, g:base16_cterm00, "bold", "")
	"Deoplete
	call Base16hi("Pmenu", "", "", g:base16_cterm01, g:base16_cterm03, "", "")
	call Base16hi("PmenuSel", "", "", g:base16_cterm03, g:base16_cterm01, "", "")
	call Base16hi("PmenuSbar", "", "", g:base16_cterm01, g:base16_cterm03, "", "")
	call Base16hi("PmenuThumb", "", "", g:base16_cterm03, g:base16_cterm01, "", "")
	" Nerdtree
	call Base16hi("Directory", "", "", g:base16_cterm0D, "", "bold", "")
	call Base16hi("TabLineSel", "", "", g:base16_cterm0E, g:base16_cterm09, "bold", "")
	call Base16hi("NERDTreeDirSlash", "", "", g:base16_cterm0D, "", "bold", "")
	call Base16hi("NERDTreeExecFile", "", "", g:base16_cterm0B, "", "bold", "")
endfunction
augroup on_change_colorschema
	autocmd!
	autocmd ColorScheme * call s:base16_customize()
augroup END

" Airline
let g:airline_theme = 'base16color'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Signify
let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
let g:signify_realtime = 0

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true)
call deoplete#custom#option('sources',	{ '_': ['buffer', 'file'],
										\ 'python': ['buffer', 'file'],
										\ })
call deoplete#custom#option('require_same_filetype', v:false)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
inoremap <expr> <Up>  pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

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
set copyindent
set smartindent
set noexpandtab
set list
set listchars=tab:\ \ ,trail:$,extends:#
set showmatch
set smartcase

" Python option
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal smarttab
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal copyindent
autocmd FileType python setlocal smartindent
