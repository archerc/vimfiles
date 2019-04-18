" ============================================================================
" File:        api.vim
" Description: some common functions
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:api")
	finish
endif

let g:api = {}

function! print(args)
	if has('python3')
		py3 print(a:args)
	endif
endfunction
