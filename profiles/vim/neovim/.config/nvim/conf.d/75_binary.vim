augroup BinaryXXD
	function! s:RunVinarise()
		if expand('%') =~ '^\*vinarise\* - .*'
			return
		endif
		Vinarise
	endfunction

	autocmd!
	autocmd BufReadPre *.bin let &binary=1
	autocmd BufReadPost * if &binary | call s:RunVinarise() | endif
augroup END
