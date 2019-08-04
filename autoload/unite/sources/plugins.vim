if exists('g:did_autoload_unite_plugins') && g:did_autoload_unite_plugins 
	finish
endif
let g:did_autoload_unite_plugins = 1

function! unite#sources#plugins#define() abort "{{{
  return s:source
endfunction "}}}

let s:source = { 
			\ 	'name': 'plugins',
			\ 	'max_candidates': 500,
			\ 	'description': 'unite plugins',
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

function! s:source.gather_candidates(args, context) abort "{{{
	return plugin_manager#init()
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

