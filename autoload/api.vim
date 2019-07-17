" ============================================================================
" File:        api.vim
" Description: some common functions
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_api")
	finish
endif
let g:loaded_api = 1

let s:is_windows = has('win32') || has('win64')

function! api#is_windows() abort
  return s:is_windows
endfunction

function! api#is_list(expr) abort
  return type(a:expr) ==# v:t_list 
endfunction

function! api#is_string(expr) abort
  return type(a:expr) ==# v:t_string 
endfunction

function! api#has_job() abort
  return (has('nvim') && exists('v:t_list'))
        \ || (has('patch-8.0.0027') && has('job'))
endfunction

function! api#debug(message)
	if has('python3')
		py3 print(a:message)
    else
      echohl Debug
      echom a:message
      echohl None
	endif
endfunction

function! api#error(messages) abort
  for line in api#split_lines(a:messages)
    echohl WarningMsg 
    echomsg '[error] ' . line 
    echohl None
  endfor
endfunction

function! api#split_lines(expr) abort
  if api#is_list(a:expr)
    return a:expr
  else
    return split(a:expr, '\n')
  endif
endfunction

function! api#expand(path) abort
  let start_with_home = a:path =~# '^\~'
  if start_with_home
    let path = fnamemodify(a:path, ':p')
  else
    let has_env_variable = a:path =~# '^\$\h\w*'
    if has_env_variable
      let path = substitute(a:path, '^\$\h\w*', '\=eval(submatch(0))', '')
    else
      let path = a:path
    endif
  endif
  return api#substitute_path(path)
endfunction

function! api#substitute_path(path) abort
  if ((api#is_windows() || has('win32unix')) && a:path =~# '\\')
    return tr(a:path, '\', '/')
  else
    return a:path
  endif
endfunction

function! api#redir(cmd) abort
  if exists('*execute')   " check builtin function exists
    return execute(a:cmd)
  else
    let [save_verbose, save_verbosefile] = [&verbose, &verbosefile]
    set verbose=0 verbosefile=
    redir => res
    silent! execute a:cmd
    redir END
    let [&verbose, &verbosefile] = [save_verbose, save_verbosefile]
    return res
  endif
endfunction

function! api#to_list(expr) abort
  if api#is_list(a:expr) 
    return copy(a:expr) :
  elseif api#is_string(a:expr)
    return (a:expr ==# '' ? [] : split(a:expr, '\r\?\n', 1))
  else
    return [a:expr]
  endif
endfunction

function! api#split_rtp(runtimepath) abort
  if stridx(a:runtimepath, '\,') < 0
    return split(a:runtimepath, ',')
  endif
  let split = split(a:runtimepath, '\\\@<!\%(\\\\\)*\zs,')
  return map(split,'substitute(v:val, ''\\\([\\,]\)'', ''\1'', ''g'')')
endfunction

function! api#add_after(rtps, path) abort
  let idx = index(a:rtps, $VIMRUNTIME)
  call insert(a:rtps, a:path, (idx <= 0 ? -1 : idx + 1))
endfunction

function! api#join_rtp(list, runtimepath, rtp) abort
  return (stridx(a:runtimepath, '\,') < 0 && stridx(a:rtp, ',') < 0) ?
        \ join(a:list, ',') : join(map(copy(a:list), 's:escape(v:val)'), ',')
endfunction

function! api#globlist(path) abort
  return split(glob(a:path), '\n')
endfunction

function! api#reset_ftplugin() abort
  let filetype_state = api#redir('filetype')
  if exists('b:did_indent') || exists('b:did_ftplugin')
    filetype plugin indent off
  endif
  if filetype_state =~# 'plugin:ON'
    silent! filetype plugin on
  endif
  if filetype_state =~# 'indent:ON'
    silent! filetype indent on
  endif
endfunction

function! api#is_reset_ftplugin(plugins) abort
  if &filetype ==# ''
    return 0
  endif
  for plugin in a:plugins
    let ftplugin = plugin.rtp . '/ftplugin/' . &filetype
    let after = plugin.rtp . '/after/ftplugin/' . &filetype
    if !empty(filter(['ftplugin', 'indent',
        \ 'after/ftplugin', 'after/indent',],
        \ "filereadable(printf('%s/%s/%s.vim',
        \    plugin.rtp, v:val, &filetype))"))
        \ || isdirectory(ftplugin) || isdirectory(after)
        \ || glob(ftplugin. '_*.vim') !=# '' || glob(after . '_*.vim') !=# ''
      return 1
    endif
  endfor
  return 0
endfunction

function! api#new(self, class) abort
  let class = api#get_class(a:class)
  if has_key(class, '__init__')
    return class.__init__(a:self)
  elseif has_key(class, '__new__')
    return class.__new__(class, a:self)
  else
    return extend(a:self, class, "keep")
  endif
endfunction

function! s:new_object(...) abort
  if empty(a:000)
    return {}
  else
    return a:1
  endif
endfunction

let s:classes = {
      \ "object": {
      \             "__init__": function("s:new_object")
      \           },
      \ "vimrc": { "__init__": function("vimrc#new") },
      \ }

function! api#get_class(name) abort
  if has_key(s:classes, a:name)
    return get(s:classes, a:name)
  else
    return {a:name}#get_class()
  endif
endfunction

function! api#set_class(name, class) abort
  let s:classes[a:name] = a:class
  return a:class
endfunction

function! api#BindKeys()
    nnoremap	<C-s>	:w<CR>
    inoremap	<C-s>	<Esc>:w<CR>
    nnoremap	<F5>	<Esc>:source %<CR>
endfunction

function! api#SetFont(font)
    let s:saved_font = &gfn
    try 
        let &gfn = a:font
    catch
        if &gfn != a:font
            let &gfn = s:saved_font
        endif
    endtry
    return &gfn
endfunction

" vim: ft=vim ts=2 sw=2 et
