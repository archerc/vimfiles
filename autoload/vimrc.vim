" ============================================================================
" File:        vimrc.vim
" Description: vimrc class
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_vimrc")
	finish
endif
let g:loaded_vimrc = 1

let s:default_vimrc = {
            \ "options": {}
            \ }
let s:vimrc_class = {
      \ "__init__": function("vimrc#new"),
      \ "apply": function("vimrc#apply"),
      \ }

function! vimrc#get_class() abort
  return s:vimrc_class
endfunction

function! vimrc#new(self) abort
    let obj = extend(a:self, s:default_vimrc, "keep")
    call vimrc#apply(obj)
    return obj
endfunction

function! vimrc#apply(self) abort
  call vimrc#load_options(a:self.options)
  call vimrc#load_plugins(a:self.plugins)
endfunction

function! vimrc#load_options(options) abort
  for option in keys(a:options)
    let vimrc_{option} = a:options[option]
    execute 'let &' . option . ' = vimrc_' . option 
  endfor
endfunction

function! vimrc#load_plugins(plugins) abort
  for plugin in a:plugins
    call api#new(plugin, 'plugin')
  endfor
endfunction

function! vimrc#load(file) abort
  let file = api#expand(a:file)
  if filereadable(file)
    let lines = readfile(file)
    return vimrc#new(json_decode(join(lines)))
  else
    call api#error('file not found')
    return {}
  endif
endfunction

" vim: ft=vim ts=2 sw=2 et
