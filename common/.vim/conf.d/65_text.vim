" 長い行を表示しようとすると重くなるのはsyntaxが原因なので、plain textと
" 断定できる場合にシンタックスハイライトを無効にする
augroup PlainText
	autocmd!
	au BufEnter,BufNewFile,BufRead *.txt set syntax=off
augroup END
