" ============================================================================
" File:        on.vim
" Description: 
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_on')
  finish
endif
let g:loaded_on = 1

function! on#VimScript(file)
    setlocal tabstop=4 shiftwidth=4 expandtab
    exe 'nnoremap <buffer> <F5>	:source ' . a:file . '<CR>'
endfunction

function! on#VimScriptModified(file)
    execute 'source ' . a:file 
    echom 'Vim script(' . a:file . ') is sourced'
endfunction

function! on#Modified(file)
    " echom 'OnModified'
    echom a:file . ' is saved'
endfunction

function! on#VimEnter()
    return api#BindKeys()
endfunction
