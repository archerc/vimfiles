" ============================================================================
" File:        plugin.vim
" Description: class plugin
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_plugin")
	finish
endif
let g:loaded_plugin = 1

let s:default_plugin = {
      \ "name": "",
      \ "url": "",
      \ }

let s:plugin_class = {
      \ "__init__": function("plugin#new"),
      \ }

let g:available_plugins = {}

function! plugin#get_class() abort
  return s:plugin_class
endfunction

function! plugin#new(self) abort
  let plugin = extend(a:self, s:default_plugin, "keep")
  let plugin.directory = plugin#directory(plugin)
  if !isdirectory(plugin.directory) && !empty(plugin.url)
    call mkdir(plugin.directory)
    call plugin#download(plugin.url, plugin.directory)
  endif
  let g:available_plugins[plugin.name] = plugin
  return plugin
endfunction

let g:plugin#directory_prefix = api#expand($VIM . '/vimfiles/bundle')
function! plugin#directory(plugin) abort
  return g:plugin#directory_prefix . '/' . a:plugin.name
endfunction

function! plugin#download(url, output) abort
  call api#debug('downloading ...')
endfunction

" vim: ft=vim ts=2 sw=2 et
