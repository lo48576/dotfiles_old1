NeoBundle 'thinca/vim-template' " Simple and flexible template engine.

if neobundle#tap('vim-template')
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:template_files = 'template/vim-template/**'
		let g:template_free_pattern = 'vim-template'
		autocmd User plugin-template-loaded call s:template_keywords()
		function! s:template_keywords()
			%s/<+FILE NAME+>/\=expand('%:t')/ge
			%s/<+ISO8601TIME+>/\=strftime('%FT%T%z')/ge
			"%s/<%=\(.\{-\}\)%>/\=eval(submatch(1))/ge
			if search('<+CURSOR+>') | execute 'normal! "_da>"' | endif
		endfunction
	endfunction
	call neobundle#untap()
endif
