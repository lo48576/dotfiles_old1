NeoBundle 'thinca/vim-template' " Simple and flexible template engine.

if neobundle#tap('vim-template')
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:template_free_pattern = 'template'
	endfunction
	call neobundle#untap()
endif
