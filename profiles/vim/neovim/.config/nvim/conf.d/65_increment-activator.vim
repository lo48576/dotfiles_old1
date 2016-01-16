" Be enabled on insert-mode
imap <silent> <C-a> <Plug>(increment-activator-increment)
imap <silent> <C-x> <Plug>(increment-activator-decrement)

let g:increment_activator_filetype_candidates = {
			\ 'cpp' : [
			\	['public', 'protected', 'private'],
			\	['int8_t', 'int16_t', 'int32_t', 'int64_t'],
			\	['uint8_t', 'uint16_t', 'uint32_t', 'uint64_t'],
			\	['signed', 'unsigned'],
			\ ],
			\ 'rust' : [
			\	['f32', 'f64'],
			\	['i8', 'i16', 'i32', 'i64'],
			\	['u8', 'u16', 'u32', 'u64'],
			\ ],
			\ '_' : [
			\ ],
			\}
