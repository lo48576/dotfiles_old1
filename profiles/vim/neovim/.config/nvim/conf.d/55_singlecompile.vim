NeoBundleLazy 'xuhdev/SingleCompile' " A Vim plugin making it more convenient to compile or run a single source file.


if neobundle#tap('SingleCompile')
	call neobundle#config({
				\	'on_cmd' : [
				\		'SCCompile', 'SCCompileRun', 'SCCompileRunAsync',
				\		'SCCompileAF', 'SCCompileRunAF', 'SCCompileRunAsyncAF',
				\		'SCChooseCompiler', 'SCChooseInterpreter',
				\		'SCIsRunningAsync', 'SCTerminateAsync', 'SCViewResult', 'SCViewResultAsync',
				\	],
				\ })
	"call neobundle#config({
				"\	'on_cmd' : [
				"\		'SCCompile',
				"\	],
				"\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:SingleCompile_alwayscompile = 0

		call SingleCompile#SetCompilerTemplate('dot', 'dot', 'dot for png', 'dot', '-Tpng -o $(FILE_TITLE)$.png', 'xdg-open $(FILE_TITLE)$.png')
		call SingleCompile#SetOutfile('dot', 'dot', '$(FILE_TITLE)$.png')
		call SingleCompile#ChooseCompiler('dot', 'dot')
	endfunction
	call neobundle#untap()
endif

nmap <F9> :SCCompile<CR>
nmap <F10> :SCCompileRun<CR>
nmap <F11> :SCCompileRunAsync<CR>
