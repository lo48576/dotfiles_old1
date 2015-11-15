" tabline and statusline settings

" always show tabline(UI)
set showtabline=2
" use textbase tabline on vim & gVim
set guioptions-=e
" show the name of current buffer in each tabpage
function! s:tabpage_label(n)
	" use t:title if exists
	let title=gettabvar(a:n,'title')
	if title !=# ''
		return title
	endif
	" list of buffers in tabpage
	let bufnrs=tabpagebuflist(a:n)
	" change highlight when current
	let hi=a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
	let bufno=len(bufnrs)
	" if there's modified buffer in tabpage, append '+'
	let mod=len(filter(copy(bufnrs),'getbufvar(v:val,"&modified")')) ? '+' : ''
	" current buffer
	" tabpagewinnr() begins from 1
	let curbufnr=bufnrs[tabpagewinnr(a:n)-1]
	let fname=pathshorten(bufname(curbufnr))
	if bufno <= 1
		let label=' ' . a:n  . mod . ' ' . fname . ' |'
	else
		let label=' ' . a:n . '>' . bufno . mod . ' ' . fname . ' |'
	endif
	return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
	let titles=map(range(1,tabpagenr('$')),'s:tabpage_label(v:val)')
	" separator between tabs(UI)
	let sep=''
	let tabpages=join(titles,sep) . sep . '%#TabLineFill#%T'
	" put info you'd like to here
	let info=''
	let info.=fnamemodify(getcwd(),':~') . ' '
	" show tablist on left, info on right
	return tabpages . '%=' . info
endfunction
set tabline=%!MakeTabLine()


"" setting of statusline
" *Don't* put 'highlight foo' before 'syntax on'
" User1 : important informations
"highlight! User1		term=bold			ctermfg=28 ctermbg=fg cterm=bold
"highlight! User1		term=bold	guifg=#005FFF guibg=fg		ctermfg=27 ctermbg=fg cterm=bold
"highlight! User1		term=bold	ctermfg=12 ctermbg=fg
set laststatus=2

" comment out: use lightline.vim instead.
"set statusline=%1*%f%m%r%h%w%*
"			\%=%{fugitive#statusline()}[br=%1*%{&ff}%*]\ [type=%1*%Y%*]\ [ASCII=%1*\%05.b%*]\ [HEX=%1*\%04.B%*]\ [POS=%1*%04l%*/%1*%04L%*,%1*%04v%*]

"			\%=[enc=%1*%{&fenc}%*]\ [br=%1*%{&ff}%*]\ [type=%1*%Y%*]\ [ASCII=%1*\%05.b%*]\ [HEX=%1*\%04.B%*]\ [POS=%1*%04l%*/%1*%04L%*,%1*%04v%*]
" if you want to display info like '[:1/3]' , write this.
" %{winnr('$')>1?'[:'.winnr().'/'.winnr('$').']':''}
