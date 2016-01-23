NeoBundleLazy 'Shougo/vinarise.vim' " Ultimate hex editing system with Vim

if neobundle#tap('vinarise.vim')
	call neobundle#config({
				\	'on_cmd' : 'Vinarise',
				\ })
	call neobundle#untap()
endif
