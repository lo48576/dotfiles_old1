" 長い行を表示しようとすると重くなるのはsyntaxが原因なので、plain textと
" 断定できる場合にシンタックスハイライトを無効にする

function! DisableSyntax()
	"if &ft =~ 'cmake\|asciidoc'
	if &ft =~ 'cmake'
		return
	endif
	set syntax=off
endfunction

augroup PlainText
	autocmd!
	"au BufEnter,BufNewFile,BufRead *.txt set syntax=off
	au BufEnter,BufNewFile,BufRead *.txt call DisableSyntax()
augroup END
