NeoBundleLazy 'Shougo/vimfiler.vim' " :file_folder: Powerful file explorer implemented by Vim script

"let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0

if neobundle#tap('vimfiler.vim')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_cmd' : [
				\		'VimFiler', 'VimFilerTab', 'VimFilerExplorer', 'VimFilerBufferDir',
				\		'Edit', 'Write', 'Read', 'Source',
				\		{
				\			'name' : 'VimFiler',
				\			'complete' : 'customlist,vimfiler#complete',
				\		},
				\	],
				\	'on_path' : '.*',
				\ })
	call neobundle#untap()
endif
