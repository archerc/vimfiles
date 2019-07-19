" ============================================================================
" File:        manager.vim
" Description: manager
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_manager')
  finish
endif
let g:loaded_manager = 1

let g:runtimepath = split(&rtp, ',')

function! manager#restore_runtimepath() abort
  let &rtp = join(g:runtimepath, ',')
  return &rtp
endfunction

function! manager#add_plugin(directory) abort
  if isdirectory(a:directory)
    let g:runtimepath = insert(g:runtimepath, a:directory, 0)
    let g:runtimepath = insert(g:runtimepath, a:directory . '/after', -1)
  endif
  return manager#restore_runtimepath()
endfunction

let g:bundle = api#expand($VIM . '/vimfiles/bundle')
function! manager#init() abort
  if isdirectory(g:bundle)
    for plugin in split(glob(g:bundle . '/*'), '\n')
      call manager#add_plugin(plugin)
    endfor
  endif
endfunction

" vim: ft=vim ts=2 sw=2 et fdm=marker 
