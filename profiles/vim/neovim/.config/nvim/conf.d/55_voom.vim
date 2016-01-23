"NeoBundleLazy 'vim-scripts/VOoM' " Vim Outliner of Markers -- two-pane outliner and related utilities
NeoBundleLazy 'vim-voom/VOoM'

if neobundle#tap('VOoM')
	call neobundle#config({
				\	'on_cmd' : ['Voom', 'Voomhelp', 'Voomexec', 'Voomlog'],
				\ })
	call neobundle#untap()
endif

NeoBundleLazy 'vim-voom/VOoM_extras' " Supplementary materials for VOoM

if neobundle#tap('VOoM_extras')
	call neobundle#config({
				\	'depends' : 'vim-voom/VOoM',
				\	'on_source' : 'VOoM',
				\ })
	call neobundle#untap()
endif
