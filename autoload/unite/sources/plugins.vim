if exists('g:did_plugin_autoload') && g:did_plugin_autoload 
	finish
endif

function! unite#sources#plugins#define() abort "{{{
  return s:source
endfunction "}}}

function! unite#sources#plugins#gather_candidates() abort  "{{{
	let s:available_plugins = []
	return s:source.gather_candidates({}, {})
endfunction "}}}

function! unite#sources#plugins#get(plugin) abort  "{{{
	let plugin_index = index(s:available_plugins, a:plugin)
	if plugin_index >= 0
		return g:plugins[plugin_index]
	else
		return {}
	endif
endfunction "}}}

" {{{ global variables
if !exists('g:load_on_construct')
	let g:load_on_construct = v:true
endif
if !exists('g:hook_on_load')
	let g:hook_on_load = v:true
endif
if !exists('g:hook_before_load')
	let g:hook_before_load = v:false
endif
if !exists('g:hook_after_load')
	let g:hook_after_load = v:true
endif
"}}}

"{{{ script variables
let s:source = { 
			\ 	'name': 'plugins',
			\ 	'max_candidates': 500,
			\ 	'description': 'candidates from plugins',
			\   'syntax': 'uniteSource__Plugins',
			\ 	'hooks': {
			\ 			'on_syntax': function('unite#sources#plugins#on_syntax'),
			\ 	},
			\ 	'default_action': 'open',
			\ 	'action_table': {
			\ 	   'open' : {
			\ 	     'description' : 'load plugin',
			\ 	     'is_selectable' : 0,
			\ 	   },
			\ 	}
			\ }
let s:disabled_plugins = [
			\     'ultisnips',
			\     'YouCompleteMe'
			\ ]

 "}}}

function! s:load_plugin() dict "{{{
	if !self.is_enabled()
		silent echom 'plugin ' . self.name . ' has been disabled'
		return
	endif
	if self.is_loaded 
		silent echom 'plugin ' . self.name . ' has been loaded'
		return
	endif
	exec 'set rtp+=' . self.directory
	if get(g:, 'hook_before_load', v:false)
		call self.run_hook('before_load')
	endif
	if get(g:, 'hook_on_load', v:true)
		let self.is_loaded = self.run_hook('on_load')
	endif
	if get(g:, 'hook_after_load', v:false)
		call self.run_hook('after_load')
	endif
endfunction "}}}

function! s:run_hook(name, ...) dict "{{{
	let escaped_name = substitute(self.name, '-', '_', 'g')
	let default_func_name = 'unite#sources#plugins#default#' . a:name
	let func_name = 'unite#sources#plugins#' . escaped_name . '#' . a:name
	let args = (a:0 > 0) ? a:000 : []
	let hook = { 
				\ 	'global' : function(default_func_name, args, self),
				\ 	'plugin' : function(func_name, args, self),
				\ }
	try
		call hook.plugin()
	catch /^Vim(call):E117: Unknown function/
		call hook.global()
	endtry
endfunction "}}}

function! s:is_enabled() dict "{{{
	let disabled_plugins = get(g:, 'disabled_plugins', s:disabled_plugins)
	return index(disabled_plugins, self.name) < 0
endfunction"}}}

function! s:get_word() dict  "{{{
	let status = self.is_enabled() ? 'enabled' : 'disabled'
	return printf('%2d  %-40s%10s', self.index, self.name, status)
endfunction "}}}

function! s:new_plugin(index, directory) abort "{{{
	let plugin = { 
				\ 	'index': (a:index < 0) ? len(s:available_plugins) : a:index, 
				\ 	'directory': a:directory,
				\   'name': fnamemodify(a:directory, ':t:r'),
				\ 	'is_available': isdirectory(a:directory),
				\ 	'is_enabled': function('<SID>is_enabled'),
				\ 	'is_loaded': v:false,
				\ 	'get_word': function('<SID>get_word'),
				\ 	'load': function('<SID>load_plugin'),
				\ 	'run_hook': function('<SID>run_hook'),
				\ }
	let plugin.word = plugin.get_word()
	if a:index < 0 || a:index == len(s:available_plugins)
		let s:available_plugins = add(s:available_plugins, plugin.name)
	else
		let s:available_plugins[a:index] = plugin.name
	endif
	if get(g:, 'load_on_construct', v:true)
		call plugin.load()
	endif
	return plugin
endfunction "}}}

function! s:source.gather_candidates(args, context) abort "{{{
	if !has_key(s:, 'available_plugins') || empty(s:available_plugins)
		let s:available_plugins = []
		let bundle = get(g:, 'bundle', $VIM . '/vimfiles/bundle')
		let g:plugins = unite#sources#plugins#default#list_directory(bundle)
		call map(g:plugins, function('<SID>new_plugin'))
	endif
	return s:available_plugins
endfunction "}}}

function! s:source.hooks.on_syntax(args, context) abort "{{{
	syntax match uniteSource__Plugins_Enabled /^.*enabled$/ contained containedin=uniteSource__Plugins
  highlight default link uniteSource__Plugins_Enabled Identifier
	syntax match uniteSource__Plugins_Disabled /^.*disabled$/ contained containedin=uniteSource__Plugins
  highlight default link uniteSource__Plugins_Disabled Exception
endfunction "}}}

function! s:source.action_table.open.func(candidate) abort "{{{
	if has_key(a:candidate, 'load')
		call a:candidate.load()
	endif
endfunction "}}}

let g:did_plugin_autoload = 1
