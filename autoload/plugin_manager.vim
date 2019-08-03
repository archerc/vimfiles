" ============================================================================
" File:        plugin_manager.vim
" Description: manager
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:did_autoload_plugin_manager') && g:did_autoload_plugin_manager 
	finish
endif
let g:did_autoload_plugin_manager = 1

function! plugin_manager#load_all_plugins() abort " {{{
	if empty(s:available_plugins)
    call s:init()
  endif
  for p in g:available_plugins
    call p.load()
  endfor
endfunction " }}}

let s:bundle = expand(fnamemodify('<sfile>', ':p:h:h') . '/bundle')
function! plugin_manager#available_plugins() abort " {{{
  let available_plugins = get(g:, 'available_plugins', s:available_plugins)
	if empty(available_plugins)
		let bundle = get(g:, 'bundle', s:bundle)
    echom 'loading plugins from ' . bundle
		for directory in plugin_manager#list_directory(bundle)
      " echom 'add plugin ' . directory
      let plugin = deepcopy(s:plugin)
      if plugin.initialize(directory)
        call add(available_plugins, plugin)
      end
    endfor
	endif
  return available_plugins
endfunction " }}}

function! plugin_manager#get(name) abort  "{{{
	let plugin_names = map(copy(s:available_plugins), {index, plugin -> plugin.name()})
  let plugin_index = index(plugin_names, a:name)
	if plugin_index >= 0
		return s:available_plugins[plugin_index]
	else
		return {}
	endif
endfunction "}}}

function! plugin_manager#list_directory(dir, ...) abort "{{{
  if isdirectory(a:dir)
    let pattern = (a:0 > 0) ? a:1 : '*'
    return split(globpath(a:dir, pattern))
  else
    return []
  endif
endfunction "}}}

let s:available_plugins = []
function! s:init() abort " {{{
	if empty(s:available_plugins)
    let s:available_plugins = plugin_manager#available_plugins()
	endif
  if empty(get(g:, 'available_plugins', []))
    let g:available_plugins = s:available_plugins
	endif
endfunction " }}}

let s:plugin = { 'is_loaded': v:false }
function! s:plugin.name() dict  " {{{
  return fnamemodify(self.directory, ':t:r')
endfunction  " }}}

let s:disabled_plugins = ['ultisnips', 'vim-gitgutter', 'YouCompleteMe']
function! s:plugin.is_enabled() dict "{{{
	let disabled_plugins = get(g:, 'disabled_plugins', s:disabled_plugins)
	return index(disabled_plugins, self.name()) < 0
endfunction " }}}

function! s:plugin.is_available() dict " {{{
  return isdirectory(self.directory)
endfunction " }}}

function! s:plugin.initialize(directory) dict  "{{{
  let self.directory = a:directory
	let status = self.is_enabled() ? 'enabled' : 'disabled'
	let self.word = printf('%-40s%10s', self.name(), status)
  return self.load()
endfunction "}}}

function! s:plugin.load() dict "{{{
	if self.is_loaded 
		silent echom 'plugin ' . self.name() . ' has been loaded'
		return v:true
	endif
	if self.is_enabled() && self.run_hook('before_load')
		let self.is_loaded = self.run_hook('on_load')
    if self.is_loaded 
      return self.run_hook('after_load')
    endif
    return self.is_loaded
  else
		silent echom 'plugin ' . self.name() . ' has been disabled'
		return v:false
  endif
endfunction "}}}

function! s:plugin.run_hook(hook, ...) dict "{{{
	let escaped_name = substitute(self.name(), '-', '_', 'g')
	let func_name = 'plugin_manager#' . escaped_name . '#' . a:hook
	let args = (a:0 > 0) ? a:000 : []
  try
    let result = call(func_name, args, self)
    let self[a:hook] = function(func_name)
    echom 'calling ' . func_name . ' returns ' . result
    return result
  catch /^Vim(let):E117/
    let default_func_name = 'plugin_manager#default#' . a:hook
    let result = call(default_func_name, args, self)
    let self[a:hook] = function(default_func_name)
    " echom 'calling ' . default_func_name  . ' returns ' . result
    return result
  endtry
endfunction "}}}

