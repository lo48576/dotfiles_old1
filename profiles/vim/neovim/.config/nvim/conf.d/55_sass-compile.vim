if executable("sass") == 1
	NeoBundleLazy 'AtsushiM/search-parent.vim' " (required by sass-compile.vim)
	NeoBundleLazy 'AtsushiM/sass-compile.vim' " Add Sass compile & utility commands.
endif

if neobundle#tap('sass-compile.vim')
	call neobundle#config({
				\	'depends' : 'AtsushiM/search-parent.vim',
				\	'on_ft' : ['scss', 'sass'],
				\	'on_cmd' : ['SassCompile', 'CompassConfig'],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		"let g:sass_compile_auto = 1
		let g:sass_compile_cdloop = 5
		let g:sass_compile_cssdir = ['css', 'stylesheet']
		let g:sass_compile_file = ['scss', 'sass']
		let g:sass_compile_beforecmd = ''
		let g:sass_compile_aftercmd = ''
	endfunction
	call neobundle#untap()
endif
