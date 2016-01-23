NeoBundle 'tomasr/molokai' " Molokai color scheme for Vim

if neobundle#tap('molokai')
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:rehash256 = 1
		autocmd ColorScheme * highlight Normal ctermbg=NONE
		autocmd ColorScheme * highlight nonText ctermbg=NONE
		colorscheme molokai
	endfunction
	call neobundle#untap()
endif

"NeoBundle 'vim-scripts/wombat256.vim' " Wombat for 256 color xterms

if neobundle#tap('wombat256.vim')
	function! neobundle#tapped.hooks.on_source(bundle)
		autocmd ColorScheme * highlight Normal ctermbg=NONE
		autocmd ColorScheme * highlight nonText ctermbg=NONE
		colorscheme wombat256mod
	endfunction
	call neobundle#untap()
endif

"NeoBundle 'vim-scripts/Wombat' " Dark gray color scheme sharing some similarities with Desert

"NeoBundle 'w0ng/vim-hybrid' " A dark color scheme for Vim & gVim

if neobundle#tap('vim-hybrid')
	function! neobundle#tapped.hooks.on_source(bundle)
		colorscheme hybrid
		autocmd ColorScheme * highlight Normal ctermbg=NONE
		autocmd ColorScheme * highlight nonText ctermbg=NONE
	endfunction
	call neobundle#untap()
endif
