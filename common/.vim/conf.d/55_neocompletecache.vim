""" neocompletecache

" enable at startup
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 5
let g:neocomplcache_manual_completion_start_length = 5
" disable auto complete
" you can use completion by C-x C-u.
let g:neocomplcache_disable_auto_complete = 1
"let g:neocomplcache_enable_underbar_completion = 1
"set completefunc=neocomplcache#manual_complete
set completefunc=neocomplcache#start_manual_complete

