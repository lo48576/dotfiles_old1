NeoBundleLazy 'jamessan/vim-gnupg' " This script implements transparent editing of gpg encrypted files. The filename must have a `.gpg`, `.pgp` or `.asc` suffix. When opening such a file the content is decrypted, when opening a new file the script will ask for the recipients of the encrypted file. The file content will be encrypted to all recipients before it is written. The script turns off viminfo, swapfile, and undofile to increase security.

if neobundle#tap('vim-gnupg')
	call neobundle#config({
				\	'on_path' : '\.\(gpg\|asc\|pgp\)$',
				\ })
	function! neobundle#tapped.hooks.on_post_source(bundle)
		" See http://leafcage.hateblo.jp/entry/nebulavim_intro .
		doautocmd GnuPG BufReadCmd,FileReadCmd
	endfunction
	call neobundle#untap()
endif
