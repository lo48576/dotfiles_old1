NeoBundleLazy 'kana/vim-submode' " Vim plugin: Create your own submodes

if neobundle#tap('vim-submode')
	call neobundle#config({
				\	'on_map' : [['n', '<C-w>>', '<C-w><', '<C-w>+', '<C-w>-']],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
		call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
		call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
		call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
		call submode#map('winsize', 'n', '', '>', '<C-w>>')
		call submode#map('winsize', 'n', '', '<', '<C-w><')
		call submode#map('winsize', 'n', '', '+', '<C-w>+')
		call submode#map('winsize', 'n', '', '-', '<C-w>-')
	endfunction
	call neobundle#untap()
endif
