NeoBundle 'sheerun/vim-polyglot' " A solid language pack for Vim.
if neobundle#tap('vim-polyglot')
	function! neobundle#tapped.hooks.on_source(bundle)
		" latex: use vim-latex
		let g:polyglot_disabled = ['latex']
	endfunction
	call neobundle#untap()
endif
