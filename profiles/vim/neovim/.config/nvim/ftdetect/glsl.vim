" common
au BufRead,BufNewFile *.glsl,*.shader set filetype=glsl
" vertex shader
au BufRead,BufNewFile *.vert,*.vp,*.vs,*.glslv set filetype=glsl
" geometry shader
au BufRead,BufNewFile *.gp,*.geom set filetype=glsl
" fragment shader
au BufRead,BufNewFile *.frag,*.fp,*.fs,*.glslf,*. set filetype=glsl
" unknown
au BufRead,BufNewFile *.tsctrl,*.tseval set filetype=glsl
