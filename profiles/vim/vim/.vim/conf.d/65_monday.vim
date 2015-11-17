" monday.vim

function! CustomizeMondayVim()
	let g:monday_sid = GetScriptID(expand($HOME) . '/.vim/bundle/monday/plugin/monday.vim')
	let Add_word_pair = function('<SNR>'.g:monday_sid.'_Add_word_pair')
	let Add_number_suffix = '<SNR>'.g:monday_sid.'_Add_Number_Suffix'
	call Add_word_pair('true;', 'false;')
	call Add_word_pair('false;', 'true;')
	call Add_word_pair('true,', 'false,')
	call Add_word_pair('false,', 'true,')
	call Add_word_pair('true', 'false')
	call Add_word_pair('false', 'true')
	call Add_word_pair('public:', 'protected:')
	call Add_word_pair('protected:', 'private:')
	call Add_word_pair('private:', 'public:')
	call Add_word_pair('on', 'off')
	call Add_word_pair('off', 'on')
	call Add_word_pair('yes', 'no')
	call Add_word_pair('no', 'yes')
	call Add_word_pair('signed', 'unsigned')
	call Add_word_pair('unsigned', 'signed')
endfunction
