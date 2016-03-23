" 編集中のファイルのディレクトリに移動
function! Cdfile()
	cd %:p:h
endfunction
command! -bar -bang -nargs=0 Cdfile call Cdfile()


" http://vim.wikia.com/wiki/Working_with_CSV_files
" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" ISO 8601 (yyyy-mm-ddThh:mm:ss+hhmm)
nnoremap <F5> "=strftime("%FT%T%z")<CR>P
inoremap <F5> <C-R>=strftime("%FT%T%z")<CR>

" Save file and create directory if necessary.
function! SaveAndWrite()
	!mkdir -p %:p:h
	w
endfunction
command! -bar -nargs=0 WW call SaveAndWrite()
