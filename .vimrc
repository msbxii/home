filetype off
call pathogen#runtime_append_all_bundles()

filetype plugin on
filetype plugin indent on

set nocompatible
syntax on

set modelines=0
set mouse=a
let mapleader = ","

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
	" Vim 7.3 specific options { 
	if version >= 703
		set relativenumber
		set undofile 
	endif
	" }
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
	" Vim 7.3 specific options {
	if version >= 703
		" set colorcolumn=81
	endif
	" }

	" let you navigate screen lines rather than system lines
	nnoremap j gj
	nnoremap k gk
" }

" Appearance {
	set t_Co=256
	set background=dark
	colorscheme peaksea
	set scrolloff=5
" }

" Convenience {
	nnoremap ; :
	nnoremap <C-e> 5<C-e>
	nnoremap <C-y> 5<C-y>
	nnoremap <leader>w :w<cr>
	nnoremap <leader>q ZZ
	inoremap <c-a> <esc>I
	inoremap <c-e> <esc>A
" }
" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Custom remaps {
	inoremap <F1> <ESC>
	nnoremap <F1> <ESC>
	vnoremap <F1> <ESC>
	inoremap jj <ESC>
	
	" generate good tags database
	map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	" auto-close preview window from omnicpp
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
	
	" low contrast for low light
	nnoremap <leader>lc :colorscheme zenburn<cr>

	" Movement {
		nnoremap <C-h> <C-w><C-h>
		nnoremap <C-j> <C-w><C-j>
		nnoremap <C-k> <C-w><C-k>
		nnoremap <C-l> <C-w><C-l>
		nnoremap H ^

	" }
	"

	nnoremap <leader>rp :RainbowParenthesesToggle<cr>

	" make a line of equals signs from the current line
	nnoremap <leader>el yypv$r=

	" make a line of asterisk from the current line
	nnoremap <leader>al yypv$r*

	" make a box comment around the current paragraph
	" Damn this mapping is legit. Clobbers mark `m' though
	nnoremap <leader>bc yy{pv$r*r/mm}Pv$r*$r/k^<c-v>`mjI*<space><esc>

	inoremap <leader><leader> <esc>
" }

" Tagbar {
	nnoremap <F8> :TagbarToggle<CR>
" }

" Session saving {
	nmap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
	function! RestoreSession()
		if filereadable('.vimsession')
			if argc() == 0 "vim called without arguments
				execute 'source .vimsession'
			end
		end
	endfunction

	autocmd VimEnter * call RestoreSession()
	" Woo let's see if this works!
" }

" Boxes {
	function! Makebox(line1, line2, override)
		let design = 'shell'
		if a:override != ''
			let design = a:override
		elseif &filetype == 'c'|| &filetype == 'cpp'
			let design = &filetype
		elseif &filetype == 'vim'
			let design = 'vim-cmt'
		endif

		exec ':' . a:line1 . ',' . a:line2 . '!boxes -d ' . design 
	endfunction
		
	command -range -nargs=0 Box  call Makebox(<line1>, <line2>, '')
	command -range -nargs=0 SexyBox call Makebox(<line1>, <line2>, 'peek')
	vnoremap ,b :Box<cr>
	vnoremap ,sexy :SexyBox<cr>
" }
