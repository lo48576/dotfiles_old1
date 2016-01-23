NeoBundleLazy 'Shougo/vimshell.vim' " :shell: Powerful shell implemented by vim.

if neobundle#tap('vimshell.vim')
	call neobundle#config({
				\	'on_cmd' : [
				\		'VimShellBufferDir', 'VimShellExecute', 'VimShellInteractive', 'VimShellTerminal', 'VimShellPop',
				\		{
				\			'name' : 'VimShell',
				\			'complete' : 'customlist,vimshell#complete',
				\		},
				\	],
				\ })
	call neobundle#untap()
endif

NeoBundleLazy 'ujihisa/vimshell-ssh' " the world first vimshell plugin that you can run `vim` command on ssh on vimshell

if neobundle#tap('vimshell-ssh')
	call neobundle#config({
				\	'depends' : 'Shougo/vimshell.vim',
				\	'on_source' : 'vimshell.vim',
				\ })
	call neobundle#untap()
endif
