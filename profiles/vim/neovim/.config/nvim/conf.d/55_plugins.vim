" use yankround.vim
"NeoBundle 'vim-scripts/YankRing.vim' " Maintains a history of previous yanks, changes and deletes
NeoBundle 'vim-scripts/sudo.vim' " Allows one to edit a file with prevledges from an unprivledged session.
NeoBundle 'kana/vim-smartchr' " Vim plugin: Insert several candidates with a single key

NeoBundle 'editorconfig/editorconfig-vim' " EditorConfig plugin for Vim
if neobundle#tap('editorconfig-vim')
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
	endfunction
endif
