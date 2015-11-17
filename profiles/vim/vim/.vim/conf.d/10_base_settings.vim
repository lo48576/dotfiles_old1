" don't save options ("globals")
set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages
" set sessionoptions=blank,buffers,curdir,folds,help,winsize,tabpages,globals

" enable syntax hilighting
" *Don't* put 'highlight foo' before 'syntax on'
syntax on

" I sometimes use linux virtual console (like agetty),
" so don't set 256color default.
" Set $TERM appropriately (normally '*-256col or') so that
" vim detect 256color support automatically.
"set t_Co=256
"set t_AB=[48;5;%dm
"set t_AF=[38;5;%dm

"set encoding=utf-8

" set default width of tab character
set tabstop=4

" don't break long line automatically
set textwidth=0

" enable autoindent
set autoindent

" prevent inserting two tab characters by autoindent
set softtabstop=4
set shiftwidth=4

" priority sequence of help
if $LANG == "ja_JP.UTF-8"
	set helplang=ja,en
else
	set helplang=en
endif

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
let maplocalleader = ";"
let mapleader = ";"

" Enable to delete characters with Bksp at any position
set backspace=2
