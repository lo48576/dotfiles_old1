" see https://twitter.com/chomado/status/497702155562659840 .
highlight TanakaHighlight ctermfg=red cterm=bold
augroup tanakaHighlight
	autocmd!
	"autocmd Colorscheme * highlight
	"			\ TanakaHighlight ctermfg=red cterm=bold
	autocmd Vimenter,WinEnter,BufRead * call
				\ matchadd("TanakaHighlight", 'tanaka')
	autocmd Vimenter,WinEnter,BufRead * call
				\ matchadd("TanakaHighlight", 'yamada')
augroup END
