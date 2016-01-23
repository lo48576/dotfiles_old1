NeoBundleLazy 'vim-scripts/python_fold' " Folding expression for python

if neobundle#tap('python_fold')
	call neobundle#config({
				\	'on_ft' : 'python',
				\ })
	call neobundle#untap()
endif
