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
    " execute 'source ' . a:file 
    call api#debug('Vim script(' . a:file . ') is sourced')
endfunction

function! on#Modified(file)
    " echom 'OnModified'
    call api#debug(a:file . ' is saved')
endfunction

function! on#VimEnter()
    call api#debug('Vim Entering')
endfunction

function! on#GuiEnter()
    let g:guifont = api#SetFont('IosevkaCC:h14:cANSI:qDRAFT')
    let g:guifont = api#SetFont('Inziu_Iosevka_SC:h14:cANSI:qDRAFT')
    " winpos 90 0
    colorscheme evening
    let g:vimrc = vimrc#load($VIM . '/vimfiles/init.json')
endfunction

