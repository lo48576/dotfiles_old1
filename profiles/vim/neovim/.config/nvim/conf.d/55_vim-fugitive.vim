NeoBundleLazy 'tpope/vim-fugitive' " fugitive.vim: a Git wrapper so awesome, it should be illegal

if neobundle#tap('vim-fugitive')
	function! neobundle#tapped.hooks.on_post_source(bundle)
		" See http://leafcage.hateblo.jp/entry/nebulavim_intro .
		doautoall fugitive BufNewFile
	endfunction
	call neobundle#untap()
endif
