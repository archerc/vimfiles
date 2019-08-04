let g:UltiSnipsSnippetsDir = expand($VIM . '/vimfiles/UltiSnips')

function! plugin_manager#ultisnips#before_load()
  return plugin_manager#setup_python3()
endfunction


