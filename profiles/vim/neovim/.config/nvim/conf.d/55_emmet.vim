" emmet for vim
NeoBundleLazy 'mattn/emmet-vim' " emmet for vim

if neobundle#tap('emmet-vim')
	call neobundle#config({
				\	'on_ft' : ['html', 'css', 'scss', 'html5', 'eruby', 'jsp', 'xml', 'coffee', 'jinja', 'mason', 'liquid'],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		" Only enable insert mode and visual mode functions.
		"let g:user_emmet_mode = 'iv'
		" Trigger key.
		"let g:user_emmet_leader_key = '<C-Y>'

		"let g:use_emmet_complete_tag = 1
		let g:user_emmet_settings = {
			  \	'variables' : {
			  \		'lang' : 'ja',
			  \	},
			  \ }

		" See [Update image size in XHTML · Issue #161 · mattn/emmet-vim](https://github.com/mattn/emmet-vim/issues/161)
		let g:emmet_html5 = 0

		" Enable just for html/css/scss and some other types.
		let g:user_emmet_install_global = 0
		autocmd FileType html,css,scss,html5,eruby,jsp,xml,coffee,jinja,mason,liquid EmmetInstall
	endfunction
	call neobundle#untap()
endif
