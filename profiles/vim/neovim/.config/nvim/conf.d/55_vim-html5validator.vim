NeoBundleLazy 'hokaccha/vim-html5validator' " html5 validator vim plugin using validator.nu API.

if neobundle#tap('vim-html5validator')
	call neobundle#config({
				\	'on_cmd' : 'HTML5Validate'
				\ })
	call neobundle#untap()
endif
