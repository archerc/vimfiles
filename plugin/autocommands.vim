" ============================================================================
" File:        autocommands.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_autocmds') && g:loaded_autocmds
  finish
endif

augroup vim_startup
  autocmd!
  autocmd   VimEnter  *   LoadAllPlugins
  autocmd   VimEnter  *   Startify
augroup END

let g:loaded_autocmds = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
