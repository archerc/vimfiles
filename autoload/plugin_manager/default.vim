if exists('g:loaded_autoload_plugins_default')
  finish
endif
let g:loaded_autoload_plugins_default = 1


function! plugin_manager#default#before_load() dict  "{{{
  return v:true
endfunction "}}}

function! plugin_manager#default#on_load() dict  "{{{
  exec 'set rtp+=' . self.directory
  let scripts = plugin_manager#list_directory(self.directory, 'plugin/*.vim')
  for file in scripts
    if filereadable(file)
      if !s:source_file(file)
        echom 'load script ' . file . ' from plugin ' . self.name() . ' is failed'
        return v:false
      endif
    endif
  endfor
  return v:true
endfunction "}}}

function! plugin_manager#default#after_load() dict  "{{{
  return v:true
endfunction "}}}

function! s:source_file(script) abort "{{{
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

