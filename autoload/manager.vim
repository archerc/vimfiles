" ============================================================================
" File:        manager.vim
" Description: manager
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:did_autoload_manager')
  finish
endif

let g:python3_home = get(g:, 'python3_home', expand($VIM . '/Python3.7.3'))
let g:python3_dll = get(g:, 'python3_dll', expand(g:python3_home . '/python37.dll'))
let g:bundle = get(g:, 'bundle', expand($VIM . '/vimfiles/bundle'))

function! manager#enable_python(...) abort
  if !has('python3')
    let python3_home = (a:0 > 0) ? a:1 : g:python3_home 
    if isdirectory(python3_home)
      let python3_dll = expand(python3_home . '/python37.dll')
      if filereadable(python3_dll)
        let &pythonthreehome = python3_home
        let &pythonthreedll = python3_dll
      endif
    endif
  endif
  return has('python3')
endfunction

function! s:set_url(channel, url) dict
  let self.url = a:url
endfunction

let s:loaded_plugins = []
function! s:load_plugin() dict
  " echom 'loading ' . self.name
  if has_key(self, 'directory') && isdirectory(self.directory)
    let files = split(glob(self.directory . '/plugin/*.vim'), '\n')
    try
      for file in files
        "echom 'loading file ' . file . ' from plugin ' . self.name 
        exec 'source ' . file
      endfor
      if index(s:loaded_plugins, self.name) < 0
        call add(s:loaded_plugins, self.name)
      endif
    catch
      call manager#disable_plugin(self.name)
      echom 'failed loading file ' . file . ' from plugin ' . self.name 
    endtry
  endif
endfunction

let s:disabled_plugins = []
function! s:disable_plugin() dict
  call manager#disable_plugin(self.name)
endfunction

function! s:is_plugin_enabled() dict
  return index(s:disabled_plugins, self.name) < 0 
        \ && ( !has_key(g:, 'disabled_plugins') 
        \      || index(g:disabled_plugins, self.name) < 0)
endfunction

let s:all_available_plugins = {}
function! manager#new_plugin(directory) abort
  if isdirectory(a:directory)
    let plugin = {
          \ 'set_url': function('<SID>set_url'),
          \ 'load': function('<SID>load_plugin'),
          \ 'disable': function('<SID>disable_plugin'),
          \ 'is_enabled': function('<SID>is_plugin_enabled'),
          \ }
    let plugin.directory = a:directory
    let plugin.name = fnamemodify(plugin.directory, ":t")
    let cmd = 'git --git-dir=' . plugin.directory . '\.git remote get-url origin'
    if exists('*job_start')
      let job = job_start(cmd, {'out_cb': plugin.set_url})
    else
      let plugin.url = split(system(cmd), '\n')[0]
    endif
    let s:all_available_plugins[plugin.name] = plugin
    return plugin
  else
    echoerr 'directory ' . a:directory . ' not found'
  endif
endfunction

function! manager#list_directory(dir) abort
  if isdirectory(a:dir)
    return split(globpath(a:dir, '*'), '\n')
  endif
endfunction

function! manager#disable_plugin(name) abort
  if index(s:disabled_plugins, a:name) < 0
    call add(s:disabled_plugins, a:name)
  endif
endfunction

function! manager#get_plugin(name) abort
  if has_key(s:all_available_plugins, a:name)
    return s:all_available_plugins[a:name]
  else
    echoerr 'plugin ' . a:name . ' not found.'
  endif
endfunction

function manager#all_available_plugins(...) abort
  let plugin_dirs = (a:0 > 0) ? a:1 : g:bundle
  for plugin_dir in manager#list_directory(plugin_dirs)
    call manager#new_plugin(plugin_dir)
  endfor
  return s:all_available_plugins
endfunction

function manager#disabled_plugin_list() abort
  return s:disabled_plugins
endfunction

let g:did_autoload_manager = 1
" vim: ft=vim ts=2 sw=2 et fdm=indent
