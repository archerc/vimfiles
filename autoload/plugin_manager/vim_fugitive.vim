function! plugin_manager#vim_fugitive#after_load() abort
  augroup fugitive_keyamp
    au!
    au  FileType gitcommit call <SID>bind_keys_gitcommit()
    au  FileType fugitive  call <SID>bind_keys_fugitive()
  augroup END
  return v:true
endfunction

function! s:bind_keys_gitcommit() abort
    nnoremap <silent> <buffer> <C-CR> :wq<CR>
    inoremap <silent> <buffer> <C-CR> <Esc>:wq<CR>
endfunction

function! s:bind_keys_fugitive() abort
    nnoremap <silent> <buffer> U :Gpush<CR>
    nnoremap <silent> <buffer> l :Gpull<CR>
endfunction
