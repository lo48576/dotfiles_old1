NeoBundleLazy 'scrooloose/nerdtree' " A tree explorer plugin for vim.

if neobundle#tap('nerdtree')
	call neobundle#config({
				\	'on_cmd' : [
				\		'NERDTree', 'NERDTreeFromBookmark', 'NERDTreeToggle', 'NERDTreeMirror',
				\		'NERDTreeClose', 'NERDTreeFind', 'NERDTreeCWD',
				\	],
				\ })
	call neobundle#untap()
endif

nnoremap <silent> <leader>t :NERDTreeToggle<CR>
