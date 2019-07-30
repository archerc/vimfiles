
let s:source = {
			\ 	'name': 'plugins',
			\ 	'max_candidates': 500,
			\ 	'description': 'candidates from plugins',
			\ 	'hooks': {},
			\ 	'default_action': 'load',
			\ 	'action_table': {
			\ 	   'load' : {
			\ 	     'description' : 'load plugin',
			\ 	     'is_selectable' : 0,
			\ 	   },
			\ 	}
			\ }

let s:available_plugins = []
let s:disabled_plugins = [
			\     'ultisnips',
			\     'YouCompleteMe'
			\ ]

function! unite#sources#plugins#define() 
  return s:source
endfunction

function! unite#sources#plugins#gather_candiates() abort
	return s:source.gather_candidates({}, {})
endfunction

function! s:load_plugin() dict
	if !self.is_loaded && self.is_enabled
		exec 'set rtp+=' . self.directory
		let scripts = filter(self.scripts, 'filereadable(v:val)')
		call map(scripts, function('<SID>source_file'))
		let self.is_loaded = v:true
	else
		echom 'plugin ' . self.word . ' has been disabled'
	endif
endfunction

function! s:new_plugin(index, directory) abort
	let name = fnamemodify(a:directory, ':t:r')
	let plugin = { 
				\ 	'index': (a:index < 0) ? len(s:available_plugins) : a:index, 
				\ 	'directory': a:directory,
				\ 	'word': name,
				\		'scripts': s:list_directory(a:directory, '/plugin/*.vim'),
				\ 	'is_available': isdirectory(a:directory),
				\   'is_enabled': index(s:disabled_plugins, name) < 0,
				\ 	'is_loaded': v:false,
				\ 	'load': function('<SID>load_plugin'),
				\ }
	if a:index < 0 || a:index == len(s:available_plugins)
		let s:available_plugins = add(s:available_plugins, plugin)
	else
		let s:available_plugins[a:index] = plugin
	endif
	call plugin.load()
	return plugin
endfunction

function! s:source.gather_candidates(args, context) abort
	if !has_key(s:, 'available_plugins') || empty(s:available_plugins)
		let bundle = get(g:, 'bundle', $VIM . '/vimfiles/bundle')
		let plugins = s:list_directory(bundle)
		call map(plugins, function('<SID>new_plugin'))
	endif
	return s:available_plugins
endfunction

function! s:source.action_table.load.func(candidate) abort
	if has_key(a:candidate, 'load')
		call a:candidate.load()
	endif
endfunction

function! s:list_directory(dir, ...) abort
  if isdirectory(a:dir)
    let pattern = (a:0 > 0) ? a:1 : '*'
    return split(globpath(a:dir, pattern))
  else
    return []
  endif
endfunction

function! s:source_file(index, script) abort
	if filereadable(a:script)
		try
			exec 'source ' . a:script
		endtry
	endif
endfunction
