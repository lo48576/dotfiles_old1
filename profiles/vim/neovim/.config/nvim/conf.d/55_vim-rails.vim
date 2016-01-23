NeoBundleLazy 'tpope/vim-rails' " rails.vim: Ruby on Rails power tools

if neobundle#tap('vim-rails')
	call neobundle#config({
				\	'on_ft' : 'ruby',
				\	'on_cmd' : ['Emodel', 'Eview', 'Econtroller', 'Rake', 'Rgenerate', 'Rrunner', 'Rextract'],
				\ })
	call neobundle#untap()
endif
