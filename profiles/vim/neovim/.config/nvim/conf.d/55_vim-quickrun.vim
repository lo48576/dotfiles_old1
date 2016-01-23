NeoBundleLazy 'thinca/vim-quickrun' " Run commands quickly.

if neobundle#tap('vim-quickrun')
	call neobundle#config({
				\	'on_map' : [
				\		['n', '<leader>r'],
				\		['nxo', '<Plug>(quickrun)'],
				\	],
				\	'on_cmd' : 'QuickRun',
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:quickrun_config = {
					\	'_' : {
					\		'outputter' : 'error',
					\		'outputter/error/success' : 'buffer',
					\		'outputter/error/error' : 'quickfix',
					\		'outputter/buffer/split' : ':rightbelow 8sp',
					\		'outputter/buffer/close_on_empty' : 1,
					\	},
					\ }
	endfunction
	call neobundle#untap()
endif
