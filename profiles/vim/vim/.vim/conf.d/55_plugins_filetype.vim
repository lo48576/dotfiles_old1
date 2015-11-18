" tar archive
NeoBundle 'tar.vim'

" gpg encrypted file
NeoBundle 'gnupg.vim'

" html/css
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'othree/html5.vim'
NeoBundle 'hokaccha/vim-html5validator'

" sass
if executable("sass") == 1
	NeoBundle 'AtsushiM/search-parent.vim' " required by sass-compile.vim
	NeoBundle 'AtsushiM/sass-compile.vim'
endif

" binary
NeoBundle 'Shougo/vinarise'

" latex
NeoBundle 'vim-latex/vim-latex'

" haskell
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'indenthaskell.vim'
NeoBundle 'haskell.vim'
NeoBundle 'pbrisbin/vim-syntax-shakespeare'

" ruby
NeoBundle 'tpope/vim-rails'

" glsl
NeoBundle 'glsl.vim'

" toml
NeoBundle 'cespare/vim-toml'

" markdown
NeoBundle 'tpope/vim-markdown'
