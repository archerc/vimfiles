" ============================================================================
" File:        api.vim
" Description: some common functions
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_api")
	finish
endif
let g:loaded_api = 1

function! api#debug(message)
	if has('python3')
		py3 print(a:message)
    else
        echom a:message
	endif
endfunction

function! api#BindKeys()
    nnoremap	<C-s>	:w<CR>
    inoremap	<C-s>	<Esc>:w<CR>
    nnoremap	<F5>	<Esc>:source %<CR>
endfunction
