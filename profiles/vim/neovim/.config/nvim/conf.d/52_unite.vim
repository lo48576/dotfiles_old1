NeoBundleLazy 'Shougo/unite.vim' " :dragon: Unite and create user interfaces

if neobundle#tap('unite.vim')
	call neobundle#config({
				\	'on_cmd' : ['Unite', 'UniteResume'],
				\ })
	call neobundle#untap()
endif
