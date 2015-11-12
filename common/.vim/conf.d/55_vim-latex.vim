""" (Vim-Latex)

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" skk is using C-j, so you can't C-j to using place-holder
let g:Imap_UsePlaceHolders = 0
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
" default target (select 'pdf' if you use Japanese)
" xvdi can't display Japanese Character but you can look it in pdf
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf='lualatex -shell-escape $*' "direct pdf
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_CompileRule_dvi = 'uplatex -interaction=nonstopmode -file-line-error-style $*'
"let g:Imap_UsePlaceHolders = 1
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'makeindex $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
"let g:Tex_ViewRule_pdf = 'xdg-open'
let g:Tex_ViewRule_pdf = 'evince'

let g:Tex_AutoFolding = 0
let g:Tex_SmartKeyQuote = 0
let g:Imap_FreezeImap = 1
