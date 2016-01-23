if executable("ctags") == 1
	NeoBundleLazy 'vim-scripts/taglist.vim' " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
endif

if neobundle#tap('taglist.vim')
	call neobundle#config({
				\	'on_cmd' : 'Tlist',
				\ })
	call neobundle#untap()
endif
