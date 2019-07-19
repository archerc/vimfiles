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

let g:plugin#directory_prefix = api#expand($VIM . '/vimfiles/bundle')
function! s:default_plugin.directory() dict
  return g:plugin#directory_prefix . '/' . self.name
endfunction

function! s:default_plugin.update() dict
  let directory = self.directory()
  let options = get(self, 'options', {"cwd": directory})
  if !isdirectory(directory) 
    call mkdir(directory)
    let self.job = job_start('git init', options)
  endif
  let self.job = plugin#download(self.url, directory, options)
endfunction

let s:plugin_class = {
      \ "__init__": function("plugin#new"),
      \ }

let g:available_plugins = {}

function! plugin#get_class() abort
  return s:plugin_class
endfunction

function! plugin#new(self) abort
  let plugin = extend(a:self, s:default_plugin, "keep")
  call plugin.update()
  let g:available_plugins[plugin.name] = plugin
  return plugin
endfunction

function! plugin#download(url, output, options) abort
  let cmd = 'git fetch ' . a:url . ''
  return job_start(cmd, extend({"cwd": a:output}, a:options))
endfunction

" vim: ft=vim ts=2 sw=2 et
