NeoBundleLazy 'gorodinskiy/vim-coloresque' " css/less/sass/html color preview for vim

if neobundle#tap('vim-coloresque')
	call neobundle#config({
				\	'on_ft' : ['html', 'html5', 'css', 'scss', 'sass', 'less', 'stylus', 'vim'],
				\ })
	call neobundle#untap()
endif
