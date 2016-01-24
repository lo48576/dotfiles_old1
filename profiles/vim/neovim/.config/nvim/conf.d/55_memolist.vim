NeoBundleLazy 'glidenote/memolist.vim' " simple memo plugin for Vim.

if neobundle#tap('memolist.vim')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_cmd' : ['MemoNew', 'MemoList', 'MemoGrep'],
				\ })
	function! neobundle#tapped.hooks.on_source(bundle)
		let g:memolist_path = "~/Documents/memo1"
		let g:memolist_memo_suffix = "adoc"
		let g:memolist_memo_date = "%FT%T%z"
		let g:memolist_prompt_tags = 1
		let g:memolist_prompt_categories = 1
		let g:memolist_qfixgrep = 1
		let g:memolist_vimfiler = 1
		let g:memolist_template_dir_path = "~/.config/nvim/template/memolist.vim"

		let g:memolist_unite = 1
		let g:memolist_unite_source = 'file_rec'
		let g:memolist_unite_option = '-start-insert'
	endfunction
	call neobundle#untap()
endif

map <Leader>mn  :MemoNew<CR>
map <Leader>ml  :MemoList<CR>
map <Leader>mg  :MemoGrep<CR>
