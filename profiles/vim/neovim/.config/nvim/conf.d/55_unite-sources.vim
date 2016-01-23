NeoBundleLazy 'ujihisa/unite-colorscheme' " A unite.vim plugin

if neobundle#tap('unite-colorscheme')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_unite' : 'colorscheme',
				\ })
	call neobundle#untap()
endif

NeoBundleLazy 'Shougo/unite-outline' " outline source for unite.vim

if neobundle#tap('unite-outline')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_source' : 'unite.vim',
				\	'on_unite' : 'outline',
				\ })
	call neobundle#untap()
endif

NeoBundleLazy 'Shougo/unite-sudo' " sudo source for unite.vim

if neobundle#tap('unite-sudo')
	call neobundle#config({
				\	'depends' : ['Shougo/unite.vim', 'Shougo/vimfiler.vim'],
				\	'on_source' : 'vimfiler.vim',
				\ })
	call neobundle#untap()
endif

NeoBundle 'hewes/unite-gtags' " Unite source for GNU GLOBAL

if neobundle#tap('unite-gtags')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_unite' : ['gtags/context', 'gtags/ref', 'gtags/def', 'gtags/grep', 'gtags/completion', 'gtags/file'],
				\ })
	call neobundle#untap()
endif

NeoBundle 'sgur/unite-qf' " quickfix source for unite.vim

if neobundle#tap('unite-qf')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_unite' : 'qf',
				\ })
	call neobundle#untap()
endif

NeoBundle 'tacroe/unite-mark'

if neobundle#tap('unite-mark')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_unite' : 'mark',
				\ })
	call neobundle#untap()
endif

NeoBundle 'mattn/unite-remotefile' " unite source for remote file

if neobundle#tap('unite-remotefile')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_unite' : 'mark',
				\ })
	call neobundle#untap()
endif

NeoBundle 'Shougo/unite-session' " unite.vim session source

if neobundle#tap('unite-session')
	call neobundle#config({
				\	'depends' : 'Shougo/unite.vim',
				\	'on_cmd' : ['UniteSessionSave', 'UniteSessionLoad'],
				\	'on_unite' : ['session', 'session/new'],
				\ })
	call neobundle#untap()
endif
