NeoBundleLazy 'tmhedberg/matchit' " extended % matching for HTML, LaTeX, and many other languages http://www.vim.org/scripts/script.php?script_id=39

if neobundle#tap('matchit')
	call neobundle#config({
				\	'on_map' : ['%', 'g%', '[%', ']%', ['a', 'a%']],
				\ })
	"function! neobundle#tapped.hooks.on_source(bundle)
	"endfunction
	call neobundle#untap()
endif
