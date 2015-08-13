" 編集中のファイルのディレクトリに移動
function! Cdfile()
	cd %:p:h
endfunction
command! -bar -bang -nargs=0 Cdfile call Cdfile()
