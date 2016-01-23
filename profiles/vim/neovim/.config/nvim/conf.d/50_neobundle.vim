if has('vim_starting')
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.config/nvim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Next generation Vim package manager
