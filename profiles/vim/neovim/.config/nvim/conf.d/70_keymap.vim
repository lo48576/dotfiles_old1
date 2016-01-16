" key mappings

" easy to type. (for qwerty, dvorak) Ctrl+@ or Ctrl+`
inoremap <C-@>		<ESC>
" Ctrl+/ (@dvorak) , Ctrl+[ (@qwerty, English)
inoremap <C-_>		<ESC>

inoremap <C-d>		<Delete>

" I'd like to use C-g to move cursor, so swap bindings
inoremap <C-S-g>u	<C-g>u
iunmap <C-g>u
inoremap <C-S-g>k	<C-g>k
iunmap <C-g>k
inoremap <C-S-g>j	<C-g>j
iunmap <C-g>j

augroup override_plugin_keymap
	" Surround.vim
	autocmd VimEnter *	iunmap <C-g>s
	autocmd VimEnter *	iunmap <C-g>S
	autocmd VimEnter *	imap <C-S-f>s	<Plug>Isurround
	autocmd VimEnter *	imap <C-S-f>S	<Plug>Ssurround
augroup END

" disable F1 (built-in) help
nmap	<F1>		<nop>
imap	<F1>		<nop>
" use F3 instead of C-j because input method with SKK uses C-j to switch mode.
imap	<F3>		<C-j>
nmap	<F3>		<C-j>

" moving cursor at insert mode (for dvorak)
" U @ qwerty
inoremap <C-g>		<Left>
" I @ qwerty
inoremap <C-c>		<Down>
" V @ qwerty
"   i want to use C-r in dvorak (C-o in qwerty)
"   but C-r is used by another function...orz
inoremap <C-k>		<Up>
" P @ qwerty
inoremap <C-l>		<Right>
