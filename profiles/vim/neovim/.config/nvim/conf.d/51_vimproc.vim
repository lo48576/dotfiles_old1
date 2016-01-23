NeoBundle 'Shougo/vimproc.vim' " Interactive command execution in Vim.

if neobundle#tap('unite-gtags')
	call neobundle#config({
				\	'build' : {
				\		'cygwin': 'make -f make_cygwin.mak',
				\		'unix': 'make -f make_unix.mak',
				\ })
	call neobundle#untap()
endif
