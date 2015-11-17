" ssh
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/unite-ssh'

" sudo
NeoBundle 'vim-scripts/sudo.vim'

" git
NeoBundle 'tpope/vim-fugitive'

" ctags/gtags
if executable("ctags") == 1
	NeoBundle 'vim-scripts/taglist.vim'
endif
NeoBundle 'vim-scripts/gtags.vim'

" info
NeoBundle 'vim-scripts/info.vim'
