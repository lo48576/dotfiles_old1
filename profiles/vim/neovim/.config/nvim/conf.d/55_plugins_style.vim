" vim style
NeoBundle 'itchyny/lightline.vim'

" colorscheme
NeoBundle 'tomasr/molokai' " Molokai color scheme for Vim
NeoBundle 'vim-scripts/wombat256.vim' " Wombat for 256 color xterms
NeoBundle 'vim-scripts/Wombat' " Dark gray color scheme sharing some similarities with Desert
NeoBundle 'w0ng/vim-hybrid' " A dark color scheme for Vim & gVim

" text style
NeoBundle 'gorodinskiy/vim-coloresque' " css/less/sass/html color preview for vim

" splash
if $LANG == "ja_JP.UTF-8"
	" Default splash uses fullwidth (non-ASCII) characters.
	NeoBundle 'thinca/vim-splash' " Changes the splash of Vim as you like.
endif
