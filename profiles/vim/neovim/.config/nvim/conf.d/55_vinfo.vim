NeoBundleLazy 'alx741/vinfo' " Vim info documentation reader, allows to read info pages when inside a Vim session or from the shell prompt (instead of Info)

if neobundle#tap('vinfo')
	call neobundle#config({
				\	'on_cmd' : ['Vinfo', 'VinfoClean', 'VinfoNext', 'VinfoPrevious'],
				\ })
	call neobundle#untap()
endif
