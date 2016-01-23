NeoBundleLazy 'vim-scripts/renamer.vim' " Use the power of vim to rename groups of files

if neobundle#tap('renamer.vim')
	call neobundle#config({
				\	'on_cmd' : 'Renamer',
				\ })
	call neobundle#untap()
endif
