" filetype settings

" enable filetype detection and plugin loading
"  and indent setting
filetype plugin indent on

" indent setting for Haskell
autocmd FileType haskell setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
" indent setting for Scheme
autocmd FileType scheme setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2
" indent setting for Python
autocmd FileType python setlocal noexpandtab softtabstop=4 shiftwidth=4 tabstop=4
" indent setting for TeX
autocmd FileType tex setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4
" indent setting for Hamlet
autocmd FileType hamlet setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4

" setting for Haskell
"au Bufenter *.hs compiler ghc