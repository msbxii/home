filetype off
call pathogen#runtime_append_all_bundles()

filetype plugin indent on

set nocompatible
syntax on

set modelines=0
set mouse=a


" General environment things {
	set backspace=indent,eol,start
	set encoding=utf-8
	set hidden
	set scrolloff=3
	set autoindent
	set showmode 
	set wildmenu
	set showcmd
	set visualbell
	" set cursorline
	set ttyfast
	set ruler
	set laststatus=2
	set relativenumber
	set undofile 
" }

" Searching {
	nnoremap / /\v
	vnoremap / /\v
	set ignorecase
	set smartcase
	set gdefault
	set incsearch
	set showmatch
	set hlsearch
	nnoremap <leader><space> :noh<cr>
	nnoremap <tab> %
	vnoremap <tab> %
" }

" Wrapping {
	set wrap
	set textwidth=79
	set formatoptions=qrn1
	set colorcolumn=81
	" let screen lines 
	nnoremap j gj
	nnoremap k gk
" }

" Convenience {
	nnoremap ; :
	nnoremap <C-e> 3<C-e>
	nnoremap <C-y> 3<C-y>
	nnoremap <leader>w :w<cr>
	nnoremap <leader>q ZZ
	let mapleader = ","
" }

" Custom remaps {
	inoremap <F1> <ESC>
	nnoremap <F1> <ESC>
	vnoremap <F1> <ESC>
	inoremap jj <ESC>
	vnoremap jj <ESC>

" }

" Session saving {
	nmap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
	function! RestoreSession()
		if argc() == 0 "vim called without arguments
			execute 'source .vimsession'
		end
	endfunction

	autocmd VimEnter * call RestoreSession()
	" Woo let's see if this works!
" }



