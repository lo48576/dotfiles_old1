" filetype settings

" enable filetype detection and plugin loading
"  and indent setting
filetype plugin indent on

autocmd Filetype text setlocal textwidth=0

" indent setting for Asciidoc
autocmd FileType asciidoc setlocal expandtab softtabstop=4 shiftwidth=4 tabstop=4
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
" textwidth setting for CMake
autocmd FileType cmake setlocal textwidth=0
" indent setting for Ruby
autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2 tabstop=2

" setting for Haskell
"au Bufenter *.hs compiler ghc
