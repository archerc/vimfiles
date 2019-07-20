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

let g:bundle = expand($VIM . '/vimfiles/bundle')
let g:plugin_dirs = split(glob(g:bundle . '/*'), '\n')

function! s:set_url(channel, url) dict
  let self.url = a:url
endfunction

function! s:load_plugin() dict
  " echom 'loading ' . self.name
  if has_key(self, 'directory') && isdirectory(self.directory)
    let files = split(glob(self.directory . '/plugin/*.vim'), '\n')
    for file in files
      try
        exec 'source ' . file
      catch
        echom 'loading file ' . file . ' from plugin ' . self.name . ' error'
      finally
      endtry
    endfor
  endif
endfunction

function! s:new_plugin(...)
  let plugin = {
        \ 'set_url': function('<SID>set_url'),
        \ 'load': function('<SID>load_plugin'),
        \ }
  " echom 'new plugin ' . join(a:000, ',')
  if a:0 > 0 && isdirectory(a:1)
    let plugin.directory = a:1
    let plugin.name = fnamemodify(plugin.directory, ":t")
    let cmd = 'git --git-dir=' . plugin.directory . '\.git remote get-url origin'
    if exists('*job_start')
      let job = job_start(cmd, {'out_cb': plugin.set_url})
    else
      let plugin.url = split(system(cmd), '\n')[0]
    endif
  else
    echom 'directory ' . a:1 . ' not found'
  endif
  call plugin.load()
  return plugin
endfunction

function s:find_plugins(plugin_dirs) abort
  let plugins = []
  for plugin_dir in a:plugin_dirs
    let plugin = s:new_plugin(plugin_dir)
    call add(plugins, plugin)
  endfor
  return plugins
endfunction

let g:plugins = s:find_plugins(g:plugin_dirs)

let g:loaded_manager = 0

" vim: ft=vim ts=2 sw=2 et fdm=marker 
