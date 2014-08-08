""" neocompletecache

" enable at startup
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 5
let g:neocomplcache_manual_completion_start_length = 5
" disable auto complete
" you can use completion by C-x C-u.
let g:neocomplcache_disable_auto_complete = 1
"let g:neocomplcache_enable_underbar_completion = 1
set completefunc=neocomplcache#manual_complete

""" LatexSuite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_CompileRule_dvi='platex -src-specials -interaction=nonstopmode -kanji=utf8 $*'
let g:Tex_ViewRule_dvi='xdvi'
" rule for \ll
let g:Tex_FormatDependency_pdf='dvi,pdf'
" command to compile dvi to pdf
let g:Tex_CompileRule_pdf='dvipdfmx $*.dvi'
" application to view pdf
let g:Tex_ViewRule_pdf='evince'
" default target (select 'pdf' if you use Japanese)
" xvdi can't display Japanese Character but you can look it in pdf
let g:Tex_DefaultTargetFormat='pdf'
" skk is using C-j, so you can't C-j to using place-holder
let g:Imap_UsePlaceHolders=1
