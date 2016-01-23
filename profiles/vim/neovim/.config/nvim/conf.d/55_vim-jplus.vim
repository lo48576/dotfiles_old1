NeoBundleLazy 'osyo-manga/vim-jplus' " Smart line joint vim plugin.

if neobundle#tap('vim-jplus')
	call neobundle#config({
				\	'on_map' : ['<Plug>(jplus)', '<Plug>(jplus-'],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:jplus#config = {
					\	'cpp' : {
					\		'right_matchstr_pattern' : '^\s*//\s*\zs.*',
					\	},
					\ }
	endfunction
	call neobundle#untap()
endif

nmap J <Plug>(jplus)
vmap J <Plug>(jplus)

"nmap <leader>J <Plug>(jplus-getchar)
"vmap <leader>J <Plug>(jplus-getchar)
nmap <leader>J <Plug>(jplus-input)
vmap <leader>J <Plug>(jplus-input)
