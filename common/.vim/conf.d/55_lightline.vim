set showtabline=2
set laststatus=2
" use textbase tabline on vim & gVim
set guioptions-=e

"set noshowmode

" basic settings
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ }
let g:lightline.enable = {
	\ 'tabline': 0
	\ }

let g:lightline.mode_map = {
	\ 'n':      'NRM',
	\ 'i':      'INS',
	\ 'R':      'RPL',
	\ 'v':      'VIS',
	\ 'V':      'V-L',
	\ 'c':      'CMD',
	\ "\<C-v>": 'V-B',
	\ 's':      'SLT',
	\ 'S':      'S-L',
	\ "\<C-s>": 'S-B',
	\ '?':      '   '
	\ }


" colorscheme settings
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
"let g:lightline#colorscheme#larry1#palette = s:p
let g:lightline#colorscheme#larry1#palette = s:p
let s:col = {}

let s:col.base = ['#808080', '#9E9E9E', 244, 247]
let s:col.base_light = ['#A8A8A8', '#D0D0D0', 248, 252]


let s:p.tabline.middle = ['#444444', '#969696', 238, 247]

unlet s:p
"let g:lightline.colorscheme = 'larry1'

" component settings
let g:lightline.component = {}
let g:lightline.component_function = {}
let g:lightline.component_visible_condition = {}

let g:lightline.component.charvaluehex4 = '%04.B'
let g:lightline.component.position = '%04l/%04L:%03v'

" use 'readonly_modified' instead
"call extend(g:lightline.component, {
	"\ 'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
	"\ 'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
	"\})
"call extend(g:lightline.component_visible_condition, {
	"\ 'readonly': '(&filetype!="help"&& &readonly)',
	"\ 'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
	"\ })

"let g:lightline.separator = {'left': '》', 'right': '《'}
let g:lightline.separator = {'left': '▶', 'right': '◀'}
let g:lightline.subseparator = {'left': '>', 'right': '<'}


" readonly_modified
call extend(g:lightline.component_function, {
	\ 'readonly_modified': 'MyReadonlyModified'
	\ })
function!	MyReadonlyModified()
	let l:is_help = (&filetype == "help")
	let l:readonly = ""
	if l:is_help
	elseif &readonly
		let l:readonly = "RO"
	endif
	let l:modified = ""
	if l:is_help
	elseif &modified
		let l:modified = "+"
	elseif &modifiable
	else
		let l:modified = "-"
	endif
	return	l:readonly . l:modified
endfunction


" fugitive
call extend(g:lightline.component_function, {
	\ 'fugitive': 'MyFugitive'
	\ })

function!	MyFugitive()
	return	exists('*fugitive#statusline') ? fugitive#statusline() : ''
	"if exists('*fugitive#head')
		"let _ = fugitive#head()
		"return strlen(_) ? 'Git:' . _ : ''
	"endif
	"return	''
endfunction


" base settings
let g:lightline.inactive = {}
"let g:lightline.inactive.left = [['filename', 'readonly_modified']]
let g:lightline.inactive.left = [['relativepath', 'readonly_modified']]
let g:lightline.inactive.right = [['position'], ['charvaluehex4'] , ['filetype'], ['fileformat'], ['fugitive']]
"let g:lightline.inactive.right = [['position'], ['charvaluehex4'] , ['filetype'], ['fileformat', 'fugitive']]
"let g:lightline.inactive.right = [['position'], ['fugitive'], ['charvaluehex4'] , ['filetype'], ['fileformat']]
let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste']] + g:lightline.inactive.left
let g:lightline.active.right = g:lightline.inactive.right

" tabline settings
let g:lightline.tab_component_function = {}

let g:lightline.component.cd = '%.35(%{fnamemodify(getcwd(), ":~")}%)'

" tabbuf_nr contains tab number, number of buffers, and modified flag (which
" indicates whether any buffer of the tab is modified, or nothing is modified).
let g:lightline.tab_component_function.tabbuf_nr = 'TabBufNr'
function!	TabBufNr(n)
	let bufnr_list = tabpagebuflist(a:n)
	let bufnr = len(bufnr_list)
	if bufnr <= 1
		let bufnr_str = ''
	else
		let bufnr_str = '>' . bufnr
	endif
	let modified_any = len(filter(copy(bufnr_list),'getbufvar(v:val,"&modified")')) ? '+' : ''
	"return	lightline#concatenate([a:n, bufnr_str], 0)
	"return	a:n . bufnr_str . lightline#tab#modified(a:n)
	return	a:n . bufnr_str . modified_any
endfunction

let g:lightline.tab_component_function.path_shorten = 'BufPathShorten'
function!	BufPathShorten(n)
	let bufnr_list = tabpagebuflist(a:n)
	let curbufnr = bufnr_list[tabpagewinnr(a:n)-1]
	return	pathshorten(bufname(curbufnr))
endfunction

let g:lightline.tabline_separator = {'left': '|', 'right': '|'}
let g:lightline.tabline_subseparator = {'left': '>', 'right': '<'}
let g:lightline.tab = {}
let g:lightline.tabline = {}
let g:lightline.tabline.left = [['tabs']]
let g:lightline.tabline.right = [['cd']]
let g:lightline.tab.inactive = ['tabbuf_nr', 'path_shorten']
"let g:lightline.tab.inactive = ['prefix', 'filename']
let g:lightline.tab.active = g:lightline.tab.inactive
