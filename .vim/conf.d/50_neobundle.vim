""" Bundle

set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle'))
endif

" vim-scripts repos
" neco-ghc depends on vimproc.
" and needs ghc-mod to be able to accessed with $PATH.
"     (Bad English...)
"NeoBundle 'neco-ghc'
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
			\	'build': {
			\		'cygwin': 'make -f make_cygwin.mak',
			\		'unix': 'make -f make_unix.mak',
			\	},
			\ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
"" editing
NeoBundle 'osyo-manga/vim-jplus'
NeoBundle 'Yggdroot/indentLine'
"" tools
""" ssh
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/unite-ssh'
""" user
NeoBundle 'vim-scripts/sudo.vim'
""" archive
NeoBundle 'vim-scripts/tar.vim'
""" git
NeoBundle 'tpope/vim-fugitive'
""" gpg
NeoBundle 'vim-scripts/gnupg.vim'
""" other
"NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/monday'
NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
NeoBundle 'aharisu/vim_goshrepl.git'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'vim-scripts/The-NERD-Commenter'
NeoBundle 'vim-scripts/The-NERD-tree'
NeoBundle 'vim-scripts/VimCalc'
"NeoBundle 'vim-scripts/VimOutliner'
"NeoBundle 'vim-scripts/vimoutliner-colorscheme-fix'
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'vim-scripts/info.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/project.tar.gz'
NeoBundle 'fuenor/qfixgrep'
"" edit
NeoBundle 'glidenote/memolist.vim'
"" filetype
""" binary
NeoBundle 'Shougo/vinarise'
""" (La)tex
"NeoBundle 'vim-scripts/tex.vim'
"NeoBundle 'vim-scripts/LaTeX-Box'
"NeoBundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
"NeoBundle 'vim-scripts/auctex.vim'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
""" haskell
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'indenthaskell.vim'
NeoBundle 'haskell.vim'
NeoBundle 'pbrisbin/vim-syntax-shakespeare'
""" ruby
NeoBundle 'tpope/vim-rails'
""" others
" c.vim needs modifying script files...
"NeoBundle 'vim-scripts/c.vim'
NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'vim-scripts/brainfuck-syntax'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Rykka/riv.vim'
"" colors
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'kana/vim-smartchr'
"" unknown
NeoBundle 'vim-scripts/neco-look'
NeoBundle 'vim-scripts/endwise.vim'
" asobi
"" status bar
"NeoBundle 'koron/u-nya-vim'
"" splash
NeoBundle 'thinca/vim-splash'
" non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'

