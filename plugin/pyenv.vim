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

let pythonhome = fnamemodify($VIM . '/Python37', ':p')
if isdirectory(pythonhome)
  let $PYTHONHOME = pythonhome
  let $PYTHONPATH = fnamemodify(pythonhome . '/lib', ':p')
  let $pythonthreehome = pythonhome
  let $pythonthreedll = fnamemodify(pythonhome . '/python37.dll', ':p')
  :py3 << EOF
print('python setup finished')
EOF
endif

let g:did_plugin_pyenv = 1
