"NeoBundleLazy 'LeafCage/yankround.vim' " logging registers and reusing them.
NeoBundle 'LeafCage/yankround.vim' " logging registers and reusing them.

if neobundle#tap('yankround.vim')
	call neobundle#config({
				\	'on_map' : '<Plug>',
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		"let g:yankround_max_history = 30
		"let g:yankround_dir = '~/.cache/yankround'
		let g:yankround_use_region_hl = 1
		"let g:yankround_region_hl_groupname = 'YankRoundRegion'
	endfunction
	call neobundle#untap()
endif

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"nmap <expr><C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "<SID>(ctrlp)"
