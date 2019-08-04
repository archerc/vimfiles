" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0



function! plugin_manager#vim_gutentags#before_load() abort
  return v:true
endfunction

let s:directory = expand($VIM . '/vimfiles/bundle/vim-gutentags')
function! s:exec(cmdline) abort 
  return iconv(expand(a:cmdline), 'cp936', 'utf-8')
endfunction

function! s:mkdir(directory) abort 
  if !isdirectory(a:directory)
    let output = s:exec('mkdir ' . a:directory)
    if !isdirectory(a:directory)
      throw 'unable to mkdir: ' . output
    endif
  endif
endfunction

function! plugin_manager#vim_gutentags#install() abort
  call s:mkdir(s:directory)
  let init = 'git -C ' . s:directory . ' init'
  let url = 'https://github.com/ludovicchabant/vim-gutentags'
  let add_url = 'git -C ' . s:directory . ' remote add origin ' . url
  let do_update = 'git -C ' . s:directory . ' pull origin master'
  let prefix = ''
  if exists(':AsyncRun')
    let prefix = 'AsyncRun '
    copen
  endif
  let sep = ' && '
  let cmdline = prefix . init . sep  . add_url . sep . do_update
  exec cmdline
endfunction
