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

function! CheckPython() " {{{
  set pythonthreedll&
  let &pythonthreehome = fnamemodify($VIM . '/../Python/3.6.8.x86', ':p')
  let &pythonthreedll = fnamemodify(&pythonthreehome . &pythonthreedll, ':p')
  if filereadable(&pythonthreedll)
    if has('python3')
      py3 import sys
      py3 print('Python {} is found'.format(sys.version))
      py3 import vim_test
    else
      echom "Python 3 is not avaliable"
    endif
  else
    echom "Python dll " . &pythonthreedll . " is not readable."
  endif
endfunction " }}}
command! CheckPython call CheckPython()

let g:did_plugin_pyenv = 1
