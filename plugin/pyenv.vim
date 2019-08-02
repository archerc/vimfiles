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
  if has('python3')
    let $PYTHONHOME = ''
    let $PYTHONPATH = ''
    py3 import sys
    py3 print(sys.executable)
    py3 print(sys.path)
  endif
endfunction " }}}

let g:did_plugin_pyenv = 1
