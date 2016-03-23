" For vim-latex.
"	IMPORTANT: grep will sometimes skip displaying the file name if you
"	search in a single file. This will confuse Latex-Suite. Set your grep
"	program to always generate a file-name.
"set grepprg=grep\ -nH\ $*

" For vim-latex.
"	OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
"	'plaintex' instead of 'tex', which results in vim-latex not being loaded.
"	The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Enable doxygen syntax highlighting
let g:load_doxygen_syntax=1
