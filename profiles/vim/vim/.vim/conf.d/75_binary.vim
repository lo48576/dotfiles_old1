"augroup BinaryXXD
	"autocmd!
	"au BufReadCmd	binary:*	call s:BinRead(expand("<afile>"))
	"au FileReadCmd	binary:*	call s:BinRead(expand("<afile>"))

	"au BufWriteCmd	binary:*	call s:BinWrite(expand("<afile>"))
	"au FileWriteCmd	binary:*	call s:BinWrite(expand("<afile>"))
"augroup END

"function!	s:BinRead(argument)
	"let l:argument = a:argument
	"let l:argument = substitute(l:argument, '^binary:', '', '')
	"let l:argument = substitute(l:argument, '^\~', $HOME, '')
	"let l:binfile = l:argument

	"let l:cat = "xxd -g 1"
	":0,$d
	"execute "r !" . l:cat . " < '" . l:binfile . "'"
	"" delete empty line
	":1d
	"set ft=xxd
	"set nomod
"endfunction

"function! s:BinWrite(argument)
	"let l:argument = a:argument
	"let l:argument = substitute(l:argument, '^binary:', '', '')
	"let l:argument = substitute(l:argument, '^\~', $HOME, '')
	"let l:binfile = l:argument

	"let l:cat = "xxd -r"
	"execute "%write !" . l:cat . " > '" . l:binfile . "'"
	"call s:BinRead(argument)
	"set nomod
"endfunction

augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | Vinarise
	autocmd BufWritePre * if &binary | Vinarise | endif
	autocmd BufWritePost * if &binary | Vinarise
augroup END

