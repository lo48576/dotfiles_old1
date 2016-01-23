NeoBundle 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting

if neobundle#tap('nerdcommenter')
	call neobundle#config({
				\	'on_map' : [['inx', '<Plug>NERDCommenter']],
				\ })
	function! neobundle#tapped.hooks.on_post_source(bundle)
		" See http://leafcage.hateblo.jp/entry/nebulavim_intro .
		doautocmd NERDCommenter BufEnter
	endfunction
	call neobundle#untap()
endif
