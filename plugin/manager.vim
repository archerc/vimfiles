" ============================================================================
" File:        manager.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_manager') && g:loaded_manager
  finish
endif

let s:all_available_plugin_names = keys(manager#all_available_plugins())
command  -nargs=1 -complete=customlist,<SID>complete_plugins LoadPlugin call <SID>load_plugin(<f-args>)

function! s:load_plugin(name) abort
  try
    let plugin = manager#get_plugin(a:name)
    call plugin.load()
  endtry
endfunction

function! s:complete_plugins(ArgLead, CmdLine, CursorPos) abort
  return s:all_available_plugin_names 
endfunction

command  LoadAllPlugins call <SID>load_all_plugins()
function! s:load_all_plugins() abort
  for name in s:all_available_plugin_names 
    call s:load_plugin(name)
  endfor
endfunction

nmap <Plug>(load-plugins) :call <SID>load_all_plugins()<CR>

let s:plugins_depends_on_python3 = [
      \ 'ultisnips', 
      \ 'YouCompleteMe', 
      \ 'vim-leader-guide' ,
      \ 'python-mode' ,
      \ 'ale' ,
      \ 'vim-bufferline' ,
      \ 'nerdtree' ,
      \ 'vim-airline' ,
      \ 'vim-gitgutter' ,
      \ 'AutoComplPop' ,
      \ ]

let g:loaded_manager = 1

" vim: ft=vim ts=2 sw=2 et fdm=indent
