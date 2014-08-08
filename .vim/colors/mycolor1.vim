" Vim color file
" Maintainer;    Larry <include.memory@gmail.com>
" Last Change:  2011 Apr 28

" mycolor1 -- dark background

set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "mycolor1"

highlight Normal		guifg=#d0d0d0 guibg=#000010						ctermfg=gray
highlight ErrorMsg		guifg=#ffffff guibg=#287eff						ctermfg=white ctermbg=lightblue
highlight Visual		guifg=#8080ff guibg=fg		gui=reverse				ctermfg=lightblue ctermbg=fg cterm=reverse
highlight VisualNOS		guifg=#8080ff guibg=fg		gui=reverse,underline	ctermfg=lightblue ctermbg=fg cterm=reverse,underline
highlight Todo			guifg=#d14a14 guibg=#1248d1						ctermfg=red	ctermbg=darkblue
highlight Search		guifg=#90fff0 guibg=#2050d0						ctermfg=white ctermbg=darkblue cterm=underline term=underline
highlight IncSearch		guifg=#b0ffff guibg=#2050d0						ctermfg=darkblue ctermbg=gray

" ZenkakuSpace : 全角スペース
"highlight ZenkakuSpace	guibg=#333333									cterm=underline
"match ZenkakuSpace /　/

" SpecialKey : 不可視文字の一部
highlight SpecialKey	guifg=#666600									ctermfg=darkgray
"highlight Directory		
"highlight Title			
"highlight WarningMsg	
highlight WildMenu		guibg=#c0c0c0									ctermbg=gray
"highlight ModeMsg		
"highlight MoreMsg		
"highlight Question		
highlight NonText		guifg=#0000aa									ctermfg=darkblue

highlight StatusLine	guibg=#ff0000									ctermbg=darkyellow
highlight StatusLineNC	guibg=#ff0000									ctermbg=darkyellow
"highlight VertSplit	

"highlight Folded		
"highlight FoldColumn	
"highlight LineNr		

"highlight DiffAdd		
"highlight DiffChange	
"highlight DiffDelete	
"highlight DiffText		

"highlight Cursor		
"highlight lCursor		

"highlight Comment		
"highlight Constant		
"highlight Special		
"highlight Identifier	
"highlight Statement	
"highlight PreProc		guifg=#10a0a0
"highlight type			
"highlight Underlined	
"highlight Ignore		

highlight Pmenu			guifg=fg guibg=#336600				ctermbg=darkgreen	ctermfg=white
highlight PmenuSel		guifg=fg guibg=#0066cc				ctermbg=darkblue	ctermfg=white
"highlight PmenuSbar	
"highlight PmenuThumb	
