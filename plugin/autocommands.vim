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

command! LoadPlugins call plugin_manager#load_all_plugins()
augroup vim_startup
  autocmd!
  autocmd   VimEnter  *   LoadPlugins
augroup END

augroup gitcommit
  autocmd!
  autocmd   FileType gitcommit  nnoremap <buffer> <C-CR> :wq<CR>
  autocmd   FileType gitcommit  inoremap <buffer> <C-CR> <Esc>:wq<CR>
augroup END

let g:loaded_autocmds = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
