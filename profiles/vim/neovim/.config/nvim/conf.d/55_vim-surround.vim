NeoBundle 'tpope/vim-surround' " surround.vim: quoting/parenthesizing made simple

if neobundle#tap('vim-surround')
	function! neobundle#tapped.hooks.on_source(bundle)
		augroup override_plugin_keymap
			autocmd VimEnter *	iunmap <C-g>s
			autocmd VimEnter *	iunmap <C-g>S
			autocmd VimEnter *	imap <C-S-f>s	<Plug>Isurround
			autocmd VimEnter *	imap <C-S-f>S	<Plug>Ssurround
		augroup END
	endfunction
	call neobundle#untap()
endif
