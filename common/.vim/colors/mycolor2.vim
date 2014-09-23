" Vim color file
" Maintainer;    Larry <include.memory@gmail.com>
" Last Change:  2011 Apr 28
" 256 colors

" mycolor2 -- dark background

set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif


let colors_name = "mycolor2"

"highlight Normal		guifg=#d0d0d0 guibg=#000010						ctermfg=252 ctermbg=16
highlight Normal		guifg=#d0d0d0 guibg=#000010						ctermfg=252
highlight ErrorMsg		guifg=#ffffff guibg=#287eff						ctermfg=15 ctermbg=33
highlight Visual		guifg=#8080ff guibg=fg		gui=reverse				ctermfg=105 ctermbg=fg cterm=reverse
highlight VisualNOS		guifg=#8080ff guibg=fg		gui=reverse,underline	ctermfg=105 ctermbg=fg cterm=reverse,underline
highlight Todo			guifg=#d14a14 guibg=#1248d1						ctermfg=166	ctermbg=26
highlight Search		guifg=#90fff0 guibg=#2050d0						ctermfg=123 ctermbg=26 cterm=underline term=underline
highlight IncSearch		guifg=#b0ffff guibg=#2050d0						ctermfg=159 ctermbg=26

" SpecialKey : 不可視文字の一部
highlight SpecialKey	guifg=#666600						ctermfg=58
"highlight Directory		
"highlight Title			
"highlight WarningMsg	
highlight WildMenu		guibg=#c0c0c0						ctermbg=250
"highlight ModeMsg		
"highlight MoreMsg		
"highlight Question		
highlight NonText		guifg=#0000aa						ctermfg=25

"highlight StatusLine	guibg=#ff0000						ctermbg=196
"highlight StatusLineNC	guibg=#ff0000						ctermbg=196
highlight StatusLine	guibg=#D75f00						ctermbg=166
highlight StatusLineNC	guibg=#D75f00						ctermbg=166
"highlight VertSplit	


"highlight Folded		
"highlight FoldColumn	
highlight LineNr		ctermfg=208
highlight CursorLineNr	term=bold,underline cterm=bold,underline
highlight CursorLine	term=none cterm=none guibg=Grey40

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
"highlight PreProc		guifg=#10a0a0						ctermfg=37
"highlight type			
"highlight Underlined	
"highlight Ignore		

highlight Pmenu			guifg=fg guibg=#336600				ctermfg=fg ctermbg=22
highlight PmenuSel		guifg=fg guibg=#0066cc				ctermfg=fg ctermbg=26
"highlight PmenuSbar	
"highlight PmenuThumb	
