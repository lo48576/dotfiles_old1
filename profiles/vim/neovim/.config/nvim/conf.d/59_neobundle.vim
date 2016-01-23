call neobundle#end()
filetype plugin indent on
NeoBundleCheck
if !has('vim_starting')
	call neobundle#call_hook('on_source')
endif
