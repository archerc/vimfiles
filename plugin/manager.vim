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

let g:disabled_plugins = []

let s:all_available_plugin_names = keys(manager#all_available_plugins())
command -bang -nargs=1 -complete=custom,<SID>complete_plugins_text LoadPlugin call <SID>load_plugin(<q-args>, <bang>0)

function! s:load_plugin(name, force) abort
  let plugin = manager#get_plugin(a:name)
  if a:force || plugin.is_enabled()
    " echom 'loading plugin ' . a:name 
    call plugin.load()
    return v:true
  else
    echom 'plugin ' . a:name . ' has been disabled in disabled_plugins'
    return v:false
  endif
endfunction

function! s:complete_plugins_text(ArgLead, CmdLine, CursorPos) abort
  return join(s:all_available_plugin_names, "\n")
endfunction

command -bang LoadAllPlugins call <SID>load_all_plugins(<bang>0)
function! s:load_all_plugins(force) abort
  for name in s:all_available_plugin_names 
    let plugin = manager#get_plugin(name)
    if (plugin.is_enabled() 
          \ && index(g:disabled_plugins, name) < 0 
          \ && index(s:plugins_depends_on_python3, name) < 0 )
      call plugin.load()
    endif
  endfor
endfunction

augroup plugin_manager
  autocmd!
  autocmd VimEnter *  LoadAllPlugins
augroup END

nmap <Plug>(load-plugins) :call <SID>load_all_plugins(0)<CR>

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
