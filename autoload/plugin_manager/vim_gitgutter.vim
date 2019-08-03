let s:git_executable = 'D:\Programs\Git\cmd\git.exe'

if filereadable(s:git_executable)
  let g:gitgutter_git_executable = s:git_executable
endif
