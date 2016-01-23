NeoBundle 'tpope/vim-endwise' " endwise.vim: wisely add `end` in ruby, endfunction/endif/more in vim script, etc

if neobundle#tap('vim-endwise')
	call neobundle#config({
				\	'on_map' : ['<Plug>DiscretionaryEnd', '<Plug>AlwaysEnd'],
				\ })
	call neobundle#untap()
endif
