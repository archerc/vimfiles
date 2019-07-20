" ============================================================================
" File:        py.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:did_plugin_pyenv') && g:did_plugin_pyenv
  finish
endif

function! UseBackSlashes(path) abort
  return substitute(a:path, '/', '\', 'g')
endfunction

let s:rtp = []
function! GetRuntimePath() abort
  if empty(s:rtp)
    let vimfiles = UseBackSlashes(fnamemodify($VIM . '/vimfiles', ':p:h'))
    let s:rtp = [$VIMRUNTIME, vimfiles]
  endif
  let &rtp = join(s:rtp, ',')
  return &rtp
endfunction

function! AddToRuntimePath(path) abort
  let path = UseBackSlashes(a:path)
  if index(s:rtp, path) < 0 && isdirectory(path)
    call add(s:rtp, path)
    echom "add to runtimepath: " a:path
  endif
  return GetRuntimePath()
endfunction

function! SetupPython() abort
  " let g:python3_home = get(g:, 'python3_home', expand($VIM . '/Python3.7.3'))
  let g:python3_home = fnamemodify($VIM . '/../Anaconda3', ':p:h')
  let g:python3_dll = get(g:, 'python3_dll', expand(g:python3_home . '/python37.dll'))
  let g:UltiSnipsUsePythonVersion = 3
  let g:_uspy = 'py3'
  if isdirectory(g:python3_home)
    if filereadable(g:python3_dll)
      let &pythonthreehome = g:python3_home
      let &pythonthreedll = g:python3_dll
    endif
  endif
  return has('python3')
endfunction

augroup pyenv
  autocmd!
  autocmd VimEnter * call SetupPython()
augroup END

let g:UltiSnipsSnippetsDir = expand($VIM . '/vimfiles/UltiSnips')

function! s:check_python() abort
  if SetupPython()
    py3 import vim
    py3 print(vim.options['runtimepath'])
  endif
endfunction
command -nargs=0 CheckPython call <SID>check_python()

let g:did_plugin_pyenv = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
