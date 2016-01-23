if executable("ag") == 1
	NeoBundleLazy 'rking/ag.vim' " Use ag, the_silver_searcher (better than ack, which is better than grep)
endif

if neobundle#tap('ag.vim')
	call neobundle#config({
				\	'on_cmd' : ['Ag', 'AgBuffer', 'AgAdd', 'AgFromSearch', 'LAg', 'LAgBuffer', 'LAgAdd', 'AgFile', 'AgHelp', 'LAgHelp'],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:unite_source_grep_command = 'ag'
		let g:unite_source_grep_default_ops = '--nogroup --nocolor --column'
		let g:unite_source_grep_recursive_opt = ''
	endfunction
	call neobundle#untap()
endif

nnoremap <silent> ,g :Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r :UniteResume search-buffer<CR>
