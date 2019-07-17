" ============================================================================
" File:        vimrc.vim
" Description: vimrc config class
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_vimrc")
	finish
endif
let g:loaded_vimrc = 1

let s:default_vimrc = {
            \ "options": {}
            \ }
let s:vimrc_class = {
      \ "__init__": function("vimrc#new")
      \ }

function! vimrc#get_class() abort
  return s:vimrc_class
endfunction

function! vimrc#new(self) abort
    return extend(a:self, s:default_vimrc, "keep")
endfunction

function! vimrc#load(file) abort
    let file = api#expand(a:file)
    if filereadable(file)
        let lines = readfile(file)
        return vimrc#new(json_decode(join(lines)))
    endif
endfunction

" vim: ft=vim ts=2 sw=2 et
