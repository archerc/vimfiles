let g:UltiSnipsSnippetsDir = expand($VIM . '/vimfiles/UltiSnips')

function! unite#sources#plugins#ultisnips#before_load()
  echom 'UltiSnips is disabled.'
  return v:false
endfunction


