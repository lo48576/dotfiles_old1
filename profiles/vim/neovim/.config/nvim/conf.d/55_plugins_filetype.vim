" gpg encrypted file
NeoBundle 'jamessan/vim-gnupg' " This script implements transparent editing of gpg encrypted files. The filename must have a `.gpg`, `.pgp` or `.asc` suffix. When opening such a file the content is decrypted, when opening a new file the script will ask for the recipients of the encrypted file. The file content will be encrypted to all recipients before it is written. The script turns off viminfo, swapfile, and undofile to increase security.

" html/css/js
NeoBundle 'mattn/emmet-vim' " emmet for vim: http://emmet.io/
" Use JulesWang/css.vim (in vim-polyglot) instead.
"NeoBundle 'hail2u/vim-css3-syntax' " Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
NeoBundle 'pangloss/vim-javascript' " Vastly improved Javascript indentation and syntax support in Vim.
NeoBundle 'hokaccha/vim-html5validator' " html5 validator vim plugin using validator.nu API.

" sass
if executable("sass") == 1
	NeoBundle 'AtsushiM/search-parent.vim' " (required by sass-compile.vim)
	NeoBundle 'AtsushiM/sass-compile.vim' " Add Sass compile & utility commands.
	" Add Sass compile & utility commands.
	"NeoBundleLazy 'AtsushiM/sass-compile.vim', { 'filetypes': ['sass', 'scss'] }
endif

" binary
NeoBundle 'Shougo/vinarise.vim' " Ultimate hex editing system with Vim

" latex
NeoBundle 'vim-latex/vim-latex' " Enhanced LaTeX support for Vim

" haskell
" (use vim-polyglot instead.)
"NeoBundle 'vim-scripts/indenthaskell.vim' " Haskell indent file
"NeoBundle 'vim-scripts/haskell.vim' " Syntax file for Haskell
"NeoBundle 'pbrisbin/vim-syntax-shakespeare' " A set of vim syntax files for highlighting the various Html templating languages in Haskell

" ruby
NeoBundle 'tpope/vim-rails' " rails.vim: Ruby on Rails power tools

" glsl
" vim-glsl is included in vim-polyglot.
"NeoBundle 'tikhomirov/vim-glsl' " Vim runtime files for OpenGL Shading Language

" toml
" vim-toml is included in vim-polyglot
"NeoBundle 'cespare/vim-toml' " Vim syntax for TOML

" markdown
" tpope/vim-markdown is included in vim-polyglot.
"NeoBundle 'tpope/vim-markdown' " Vim Markdown runtime files

" python
NeoBundle 'vim-scripts/python_fold' " Folding expression for python

" almighty
NeoBundle 'sheerun/vim-polyglot' " A solid language pack for Vim.
