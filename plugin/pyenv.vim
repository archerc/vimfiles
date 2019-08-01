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

function! GetRuntimePath() abort
  let rtp = filter(split(UseBackSlashes(&rtp), ','), 'isdirectory(v:val)')
  let &rtp = join(rtp, ',')
  return rtp
endfunction

function! AddToRuntimePath(path) abort
  let path = UseBackSlashes(a:path)
  let rtp = GetRuntimePath()
  if index(rtp, path) < 0 && isdirectory(path)
    let rtp = add(rtp, path)
    echom "add to runtimepath: " path
  endif
  return rtp
endfunction

" let g:python3_home = fnamemodify($VIM . '/../Anaconda3', ':p:h')
let g:python3_home = fnamemodify($VIM . '/Python3.7.3', ':p')

function! SetupPython(python3_home) abort
  let python3_home = get(a:, 'python3_home', g:python3_home)
  echo 'python3_home is set to ' . python3_home 
  if isdirectory(python3_home)
    let python3_dll = expand(python3_home . '/python37.dll')
    echo 'python3_dll is set to ' . python3_dll
    if filereadable(python3_dll)
      echo 'setting pythonthreehome to ' . python3_home
      let &pythonthreehome = python3_home
      let &pythonthreedll = python3_dll
      let g:UltiSnipsUsePythonVersion = 3
      let g:_uspy = 'py3'
    else
      echo 'file ' . python3_dll . ' is not readable.'
    endif
  else
    echo 'directory ' . python3_home . ' does not exist.'
  endif
  return has('python3')
endfunction

augroup pyenv
  autocmd!
  "autocmd VimEnter * call SetupPython()
augroup END

let g:UltiSnipsSnippetsDir = expand($VIM . '/vimfiles/UltiSnips')

function! s:check_python() abort
  if SetupPython()
    py3 import vim
    py3 <<EOF
try:
  import shutil
except UnicodeDecodeError,ImportError:
  pass
EOF
  endif
endfunction
command -nargs=0 CheckPython call <SID>check_python()

let g:did_plugin_pyenv = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
