function! unite#sources#plugins#define() 
  return s:source
endfunction

function! unite#sources#plugins#init() 
	let g:disabled_plugins = [
				\     'ultisnips',
				\     'YouCompleteMe'
				\ ]
	return s:source.gather_candidates({}, {})
endfunction

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

let s:available_plugins = []
let s:disabled_plugins = []

function! s:load_plugin() dict
	if !self.is_enabled
		echom 'plugin ' . self.name . ' has been disabled'
		return
	endif
	if self.is_loaded 
		echom 'plugin ' . self.name . ' has been loaded'
		return
	endif
	exec 'set rtp+=' . self.directory
	call self.run_hook('before_load')
	let scripts = filter(self.scripts, 'filereadable(v:val)')
	call map(scripts, function('<SID>source_file'))
	let self.is_loaded = v:true
	call self.run_hook('after_load')
endfunction

function! s:run_hook(name, ...) dict "{{{
	let escaped_name = substitute(self.name, '-', '_', 'g')
	let func_name = 'unite#sources#plugins#' . escaped_name . '#' . a:name
	let args = (a:0 > 0) ? a:000 : []
	let hook = { 'command' : function(func_name, args, self) }
	try
		call hook.command()
	catch /^Vim(call):E117: Unknown function/
	endtry
endfunction "}}}

function! s:new_plugin(index, directory) abort "{{{
	let plugin = { 
				\ 	'index': (a:index < 0) ? len(s:available_plugins) : a:index, 
				\ 	'directory': a:directory,
				\   'name': fnamemodify(a:directory, ':t:r'),
				\		'scripts': s:list_directory(a:directory, '/plugin/*.vim'),
				\ 	'is_available': isdirectory(a:directory),
				\ 	'is_loaded': v:false,
				\ 	'load': function('<SID>load_plugin'),
				\ 	'run_hook': function('<SID>run_hook'),
				\ }
	let disabled_plugins = get(g:, 'disabled_plugins', s:disabled_plugins)
	let plugin.is_enabled = index(s:disabled_plugins, plugin.name) < 0
	let plugin.word = printf('%2d  %-40s%10s', plugin.index, plugin.name, (plugin.is_enabled ? 'enabled' : 'disabled'))
	if a:index < 0 || a:index == len(s:available_plugins)
		let s:available_plugins = add(s:available_plugins, plugin)
	else
		let s:available_plugins[a:index] = plugin
	endif
	call plugin.load()
	return plugin
endfunction "}}}

function! s:source.gather_candidates(args, context) abort "{{{
	if !has_key(s:, 'available_plugins') || empty(s:available_plugins)
		let bundle = get(g:, 'bundle', $VIM . '/vimfiles/bundle')
		let plugins = s:list_directory(bundle)
		call map(plugins, function('<SID>new_plugin'))
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

function! s:list_directory(dir, ...) abort "{{{
  if isdirectory(a:dir)
    let pattern = (a:0 > 0) ? a:1 : '*'
    return split(globpath(a:dir, pattern))
  else
    return []
  endif
endfunction "}}}

function! s:source_file(index, script) abort "{{{
	if filereadable(a:script)
		try
			exec 'source ' . a:script
		endtry
	endif
endfunction "}}}

" vim: fdm=marker
