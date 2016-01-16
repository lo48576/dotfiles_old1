" ssh
NeoBundle 'ujihisa/vimshell-ssh' " the world first vimshell plugin that you can run `vim` command on ssh on vimshell

" sudo
NeoBundle 'vim-scripts/sudo.vim' " Allows one to edit a file with prevledges from an unprivledged session.
NeoBundle 'Shougo/unite-sudo' " sudo source for unite.vim

" git
NeoBundle 'tpope/vim-fugitive' " fugitive.vim: a Git wrapper so awesome, it should be illegal

" ctags/gtags
if executable("ctags") == 1
	NeoBundle 'vim-scripts/taglist.vim' " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
endif
NeoBundle 'vim-scripts/gtags.vim' " Integrates GNU GLOBAL source code tag system with VIM.
NeoBundle 'hewes/unite-gtags' " Unite source for GNU GLOBAL
