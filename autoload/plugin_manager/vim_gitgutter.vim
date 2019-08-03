let s:git_executable = 'D:\Programs\Git\cmd\git.exe'

function! plugin_manager#vim_gitgutter#before_load() abort
  if filereadable(s:git_executable)
    let g:gitgutter_git_executable = s:git_executable
  endif
  return v:false
endfunction
