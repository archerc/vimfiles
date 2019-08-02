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
  let $PYTHONHOME = ''
  let $PYTHONPATH = ''
  let &pythonthreehome = expand($VIM . '/Python3.7.3amd64')
  let &pythonthreedll = expand(&pythonthreehome . '/python37.dll')
  if has('python3')
    py3 import sys
    py3 print('Python 3 {} is found'.format(sys.executable))
  else
    echom "Python 3 is not avaliable"
  endif
endfunction " }}}
command! CheckPython call CheckPython()

let g:did_plugin_pyenv = 1
