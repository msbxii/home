filetype off
call pathogen#runtime_append_all_bundles()

filetype plugin on
filetype plugin indent on

set nocompatible
syntax on

" indentation to 4 spaces
set sw=4
set ts=4

set modelines=0
set mouse=a
let mapleader = ","

set tags=./tags,tags,~/.vim/nettags

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
	" not sure how I feel about this one...
	" set cursorline
	
	" If you're in a good terminal this is nice
	set ttyfast

	" needs ruler for sure
	set ruler
	set laststatus=2
	set number
	" Vim 7.3 specific options { 
	if version >= 703
		set relativenumber
		set undofile 
	endif
	" }
" }
" Filetype commands {

	au BufNewFile,BufRead *.tex,*.txt,*.md setlocal spell 

" }

" Searching {
"	nnoremap / /\v " These get annoying
" 	vnoremap / /\v
	set ignorecase
	set smartcase
	" set gdefault "suuuper annoying, turns off /g flag
	set incsearch
	set showmatch
	set hlsearch
	" get rid of highlighted crap on screen
	nnoremap <leader><space> :noh<cr>
	" nnoremap <tab> %
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
	let defaultcolorscheme= 'peaksea'
	let colorscheme_alt1='zenburn'
	let colorscheme_alt2='wombat'
	exec ':colorscheme ' . defaultcolorscheme
	set scrolloff=5

	" todo: add a high-contrast theme
	let colorschemestate = 1
	function! ToggleColorscheme()
		if g:colorschemestate == 0
			set background=dark
			exec ':colorscheme ' . g:defaultcolorscheme
			let g:colorschemestate = 1
		elseif g:colorschemestate == 1
			exec ':colorscheme ' . g:colorscheme_alt1
			let g:colorschemestate = 2
		elseif g:colorschemestate == 2
			exec ':colorscheme ' . g:colorscheme_alt2
			let g:colorschemestate = 0
		endif
	endfunc

	" switch between low [co]ntrast and medium contrast
	nnoremap <leader>co :call ToggleColorscheme()<cr>
	
	" [l]ow [c]ontrast for low light
	nnoremap <leader>lc :colorscheme zenburn<cr>:let g:colorschemestate=2<cr>
	" [h]igh [c]ontrast for other situations
	nnoremap <leader>hc :colorscheme wombat<cr>:let g:colorschemestate=0<cr>
	" [m]edium [c]ontrast, default.
	nnoremap <leader>mc :colorscheme peaksea<cr>:let g:colorschemestate=1<cr>
" }

" Convenience {
	" who uses semicolon? 
	nnoremap ; :
	" move the screen without moving cursor
	nnoremap <C-e> 5<C-e>
	nnoremap <C-y> 5<C-y>
	" [w]rite
	nnoremap <leader>w :w<cr>
	" [q]uit
	nnoremap <leader>q ZZ
	" jump to beginning/end of line while editing (emacs binding)
	inoremap <c-a> <esc>I
	inoremap <c-e> <esc>A
" }
" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Custom remaps {
	" don't need F1, probably just reaching for esc
	inoremap <F1> <ESC>
	nnoremap <F1> <ESC>
	vnoremap <F1> <ESC>
	" get out of insert mode faster
	inoremap jj <esc>
	inoremap jk <esc>
	inoremap kj <esc>
	inoremap <c-c> <esc>
	inoremap <leader><leader> <esc>

	" move between tabs
	nnoremap <F9> :tabp<cr>
	nnoremap <F10> :tabn<cr>

	" del from cursor and append to next line with 
	" indentation. useful in commenting C, or breaking
	" up function definitions
	nnoremap <leader>nl i<cr><esc>A<del><esc>

	inoremap <leader>theta Θ
	" space starts insert of a single char
	nnoremap <space> i_<esc>r
	
	" generate good tags database
	map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

	" in case the function keys are unavailable,
	" typing :MakeTags will gen a tags database
	function! MakeTags_i()
		exec ':!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
	endfunc
	command -nargs=0 MakeTags call MakeTags_i()


	" auto-close preview window from omnicpp
	autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif


	" Movement {
		" Navigate windows with ctrl
		nnoremap <C-h> <C-w><C-h>
		nnoremap <C-j> <C-w><C-j>
		nnoremap <C-k> <C-w><C-k>
		nnoremap <C-l> <C-w><C-l>
		" carat is too far away for me
		nnoremap H ^

	" }
	"

	" [R]ainbow[P]arentheses binding
	nnoremap <leader>rp :RainbowParenthesesToggle<cr>

	" make a [l]ine of [e]cquals signs from the current line
	nnoremap <leader>le yypv$r=

	" make a [l]ine of [a]sterisk from the current line
	nnoremap <leader>la yypv$r*

	" make a [b]ox [c]omment around the current paragraph
	" Damn this mapping is legit. Clobbers mark `m' though
	nnoremap <leader>bc yy{pv$r*r/mm}Pv$r*$r/k^<c-v>`mjI*<space><esc>

" }

" Tagbar {
	nnoremap <F8> :TagbarToggle<CR>
" }

" Session saving {
	" type SQ to make a session and exit. Saves window
	" and tab states
	nmap SQ <ESC>:mksession! .vimsession<CR>:wqa<CR>
	func! RestoreSession()
		if filereadable('.vimsession')
			if argc() == 0 "vim called without arguments
				execute 'source .vimsession'
			endif 
		endif 
	endfunc

	autocmd VimEnter * call RestoreSession()
	" Woo let's see if this works!
" }

" Boxes {
	" Makebox will try to use the proper box type for the
	" current file.  Can be much smarter than it is at the
	" moment but I don't really work on any other file types
	" right now. Defaults to shell ('#') comments
	func! Makebox(line1, line2, override)
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
	" mappings for boxes
	vnoremap <leader>b :Box<cr>
	vnoremap <leader>sexy :SexyBox<cr>
" }


" I suck at typing {{
	" don't need man lookups when I'm in visual mode
	vnoremap K k
	" don't need whatever the stupid J mapping is in visual mode
	vnoremap J j 
" }}


" Status line {{{

" todo: something cool here
"augroup ft_statuslinecolor
    "au!

    "au InsertEnter * hi StatusLine ctermfg=196 guifg=#FFa1aa
    "au InsertLeave * hi StatusLine ctermfg=0 guifg=#CD5907
"augroup END

set statusline=%f    " Path.
set statusline+=%#redbar#
set statusline+=%m   " Modified flag.
set statusline+=%*
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c%03V)

" }}}
"
"
set t_Co=256
"set t_Co=4

" take local config definitions. Use on low power
" machines to override some of the more liberally used
" things (set t_Co=4 is a good one). Put this stuff in
" ~/.vim_local
let $VIMLOC=expand("~")."/.vim_local"

if filereadable($VIMLOC)
	source $VIMLOC
endif


"powerline {
" let g:Powerline_symbols = 'fancy'
"}
