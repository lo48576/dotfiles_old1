let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_ignore_case = 1

" Disable auto complete.
"let deoplete#disable_auto_complete = 1

" Define dictionary.
"let g:deoplete#sources = {}
"let g:deoplete#sources.cpp = ['buffer', 'tag']

" Define keyword.
if !exists('g:deoplete#keyword_patterns')
	let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns.default = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     deoplete#mappings#undo_completion()
" NOTE: deoplete#mappings#complete_common_string() doesn't exist (2016-01-15)
"inoremap <expr><C-l>     deoplete#mappings#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
	return deoplete#mappings#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? deoplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  deoplete#mappings#close_popup()
"inoremap <expr><C-e>  deoplete#cancel_popup()

" hard to press 'C-x' on dvorak keyboard, C-u makes completion easier.
"inoremap <expr><C-u>	pumvisible() ? neocomplete#cancel_popup() : "\<C-x>\<C-u>"
inoremap <expr><C-u>	pumvisible() ? deoplete#mappings#cancel_popup() : deoplete#mappings#start_manual_complete()
inoremap <expr><C-e>	pumvisible() ? neocomplete#mappings#cancel_popup() : "\<C-e>"

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
