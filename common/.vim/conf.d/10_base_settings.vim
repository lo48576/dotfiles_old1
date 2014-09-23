""" base settings

" always show line number
set number

" don't save options ("globals")
set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages
" set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages,globals

" enable syntax hilighting
" *Don't* put 'highlight foo' before 'syntax on'
syntax on

if $COLORTERM != ""
	"source ~/.vimrc.256color
	" for xterm-256color
	" force enable 256 colors
	set t_Co=256
	set t_AB=[48;5;%dm
	set t_AF=[38;5;%dm
	colorscheme mycolor2
	highlight! User1		term=bold	guifg=#005FFF guibg=fg		ctermfg=27 ctermbg=fg cterm=bold
else
	"source ~/.vimrc.16color
	" for terminals which don't support 256colors
	colorscheme mycolor_16
	highlight! User1		term=bold	guifg=#005FFF guibg=fg		cterm=reverse	ctermbg=1
endif

"" ///* settings *///

" use highlight 'CursorLineNr'
set cursorline

" set width of tab character
set tabstop=4

" don't break long line automatically
set textwidth=0

" enable autoindent
set autoindent
" prevent inserting two tab characters by autoindent
set softtabstop=4
set shiftwidth=4

" font and size (gVim)
"set guifont=Monospace:h12:cSHIFTJIS
set guifont=Ricty\ 11
"set guifont=Dejavu\ Sans\ Mono\ 10
"set guifont=Ubuntu\ Mono\ 11

" linespace (gVim)
set linespace=1

" make whitespace characters visible
set list

" tab:tab(capital,subsequent), trail:whitespace(0x20) at the end of line, eol:end of line, nbsp:0xa0
" these must be halfwidth characters.
set listchars=tab:>\ ,trail:-,eol:$,extends:>,precedes:<,nbsp:.

" don't use bell or visual bell
set vb t_vb=

" priority sequence of help
"set helplang=ja,en
set helplang=en

" use clipboad of Operating System
"set clipboard+=unnamed


" file
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set ffs=unix,dos,mac

" width of ambiguous width character (like U+25CB(WHITE CIRCLE))
"   setting which will prevent part of unicode figures collapsing.
"   This setting, however, won't work because some of the software (like gnome-terminal)
"     will use its own settings.
"   Ambiguous Width Characters are the characters whose width isn't stipulated by Unicode.
"   Their width changes by where they appears in context.
if exists('&ambiwidth')
	set ambiwidth=double
endif

" leader
"let maplocalleader = "\<C-b>"
let maplocalleader = ";"
let mapleader = ";"

