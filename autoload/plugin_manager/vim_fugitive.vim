function! plugin_manager#vim_fugitive#after_load() abort
  augroup gitcommit
    au!
    au  FileType gitcommit nnoremap <buffer> <C-CR> :wq<CR>
    au  FileType gitcommit inoremap <buffer> <C-CR> <Esc>:wq<CR>
  augroup END
  return v:true
endfunction
