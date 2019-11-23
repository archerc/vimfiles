let g:pymode = 1
let g:pymode_python = 'python3'
let g:pymode_paths = []
let g:pymode_warnings = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint = 0
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_breakpoint_cmd = ''
let g:pymode_lint = 0
let g:pymode_lint_on_write = 1
let g:pymode_lint_unmodified = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = "E501,W"
let g:pymode_lint_select = "E501,W0011,W430"
let g:pymode_lint_sort = []
let g:pymode_lint_cwindow = 1
let g:pymode_lint_signs = 1
let g:pymode_lint_todo_symbol = 'WW'
let g:pymode_lint_comment_symbol = 'CC'
let g:pymode_lint_visual_symbol = 'RR'
let g:pymode_lint_error_symbol = 'EE'
let g:pymode_lint_info_symbol = 'II'
let g:pymode_lint_pyflakes_symbol = 'FF'

function! plugin_manager#python_mode#before_load()  abort 
  let runtimepath = split(&rtp, ',')
  for p in runtimepath
    let pymode_package_dir = fnamemodify(expand(p), ':p') . 'pymode'
    if isdirectory(pymode_package_dir)
      call insert(g:pymode_paths, pymode_package_dir, 0) 
      echo g:pymode_paths
    endif
  endfor
	return v:true
endfunction

function! plugin_manager#python_mode#after_load()  abort 
  nnoremap <F5> :PymodeRun<CR>
	return v:true
endfunction
