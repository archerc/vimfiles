function! unite#sources#plugins#default#on_load() dict  "{{{
	let scripts = unite#sources#plugins#default#list_directory(self.directory, 'plugin/*.vim')
	call filter(scripts, 'filereadable(v:val)')
	let results = copy(scripts)
	call map(results, function('<SID>source_file'))
	call filter(results, '!v:val')
	return empty(results)
endfunction "}}}

function! unite#sources#plugins#default#after_load() dict  "{{{
	return []
endfunction "}}}

function! unite#sources#plugins#default#init()  "{{{
	call unite#sources#plugins#gather_candidates()
	let plugins = copy(g:plugins)
	let enabled = filter(plugins, 'v:val.is_enabled()')
	return enabled
endfunction "}}}

function! unite#sources#plugins#default#list_directory(dir, ...) abort "{{{
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
			if get(g:, 'verbose_source_script', v:false)
				echom 'loading script ' . a:script
			endif
			exec 'source ' . a:script
			return v:true
		catch /^Vim/
			echom v:exception
			return v:false
		endtry
	endif
endfunction "}}}

