" ============================================================================
" File:        plug.vim
" Description: plugin manager
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists("g:loaded_plug")
	finish
endif
let g:loaded_plug = 1

function! plug#_init() abort
  let g:plug#_block_level = 0
  let g:plug#_runtime_path = ''
  let g:plug#_cache_path = ''
  let g:plug#cache_directory = ''
  let g:plug#_base_path = ''
  let g:plug#_hook_add = ''
  let g:plug#_plugins = {}
  let g:plug#_vimrcs = []
  " let g:plug#_cache_version = 150
  " let g:plug#_merged_format =
  "       \ "{'repo': v:val.repo, 'rev': get(v:val, 'rev', '')}"
  " let g:plug#_merged_length = 3
  " let g:plug#name = ''
  " let g:plug#plugin = {}
  " let g:plug#_ftplugin = {}
  " let g:plug#_off1 = ''
  " let g:plug#_off2 = ''
  " let g:plug#_event_plugins = {}
  " let g:plug#_is_sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER
  "       \ && $HOME !=# expand('~'.$USER)
  "       \ && $HOME ==# expand('~'.$SUDO_USER)
  " let g:plug#_progname = fnamemodify(v:progname, ':r')
  " let g:plug#_init_runtimepath = &runtimepath
  augroup dein
    autocmd!
    autocmd FuncUndefined * call plug#_on_func(expand('<afile>'))
    autocmd BufRead *? call plug#_on_default_event('BufRead')
    autocmd BufNew,BufNewFile *? call plug#_on_default_event('BufNew')
    autocmd VimEnter *? call plug#_on_default_event('VimEnter')
    autocmd FileType *? call plug#_on_default_event('FileType')
    " autocmd BufWritePost *.vim,*.toml,vimrc,.vimrc call plug#_check_vimrcs()
  augroup END
  augroup dein-events | augroup END
  if !exists('##CmdUndefined') | return | endif
  autocmd dein CmdUndefined *
        \ call plug#_on_pre_cmd(expand('<afile>'))
endfunction

function! plug#_check_vimrcs() abort
  let time = getftime(plug#_get_runtime_path())
  let ret = !empty(filter(map(copy(g:plug#_vimrcs), 'getftime(expand(v:val))'),
        \ 'time < v:val'))
  if !ret
    return 0
  endif
  call plug#clear_state()
  if get(g:, 'plug#auto_recache', 0)
    silent execute 'source' plug#_get_myvimrc()
    if plug#_get_merged_plugins() !=# plug#_load_merged_plugins()
      call plug#notify('auto recached')
      call plug#recache_runtimepath()
    endif
  endif
  return ret
endfunction

function! plug#notify(msg) abort
  call dein#util#_set_default(
        \ 'g:dein#enable_notification', 0)
  call dein#util#_set_default(
        \ 'g:dein#notification_icon', '')
  call dein#util#_set_default(
        \ 'g:dein#notification_time', 2)
  if !g:dein#enable_notification || a:msg ==# '' || has('vim_starting')
    call dein#util#_error(a:msg)
    return
  endif
  let icon = dein#util#_expand(g:dein#notification_icon)
  let title = '[dein]'
  let cmd = ''
  if executable('notify-send')
    let cmd = printf('notify-send --expire-time=%d',
          \ g:dein#notification_time * 1000)
    if icon !=# ''
      let cmd .= ' --icon=' . string(icon)
    endif
    let cmd .= ' ' . string(title) . ' ' . string(a:msg)
  elseif dein#util#_is_windows() && executable('Snarl_CMD')
    let cmd = printf('Snarl_CMD snShowMessage %d "%s" "%s"',
          \ g:dein#notification_time, title, a:msg)
    if icon !=# ''
      let cmd .= ' "' . icon . '"'
    endif
  elseif dein#util#_is_mac()
    let cmd = ''
    if executable('terminal-notifier')
      let cmd .= 'terminal-notifier -title '
            \ . string(title) . ' -message ' . string(a:msg)
      if icon !=# ''
        let cmd .= ' -appIcon ' . string(icon)
      endif
    else
      let cmd .= printf("osascript -e 'display notification "
            \        ."\"%s\" with title \"%s\"'", a:msg, title)
    endif
  endif
  if cmd !=# ''
    call dein#install#_system(cmd)
  endif
endfunction

function! plug#_get_merged_plugins() abort
endfunction

function! plug#_load_merged_plugins() abort
endfunction

function! plug#clear_state() abort
endfunction

function! plug#_on_pre_cmd(name) abort
  call plug#source(
        \ filter(dein#util#_get_lazy_plugins(),
        \ "index(map(copy(get(v:val, 'on_cmd', [])),
        \            'tolower(v:val)'), a:name) >= 0
        \  || stridx(tolower(a:name),
        \            substitute(tolower(v:val.normalized_name),
        \                       '[_-]', '', 'g')) == 0"))
endfunction

function! plug#_on_default_event(event) abort
  let lazy_plugins = plug#_get_lazy_plugins()
  let plugins = []
  let path = expand('<afile>')
  " For ":edit ~".
  if fnamemodify(path, ':t') ==# '~'
    let path = '~'
  endif
  let path = api#expand(path)
  for filetype in split(&l:filetype, '\.')
    let plugins += filter(copy(lazy_plugins),
          \ "index(get(v:val, 'on_ft', []), filetype) >= 0")
  endfor
  let plugins += filter(copy(lazy_plugins),
        \ "!empty(filter(copy(get(v:val, 'on_path', [])),
        \                'path =~? v:val'))")
  let plugins += filter(copy(lazy_plugins),
        \ "!has_key(v:val, 'on_event')
        \  && has_key(v:val, 'on_if') && eval(v:val.on_if)")
  call s:source_events(a:event, plugins)
endfunction

function! s:source_events(event, plugins) abort
  if empty(a:plugins)
    return
  endif
  let prev_autocmd = execute('autocmd ' . a:event)
  call plug#source(a:plugins)
  let new_autocmd = execute('autocmd ' . a:event)
  if a:event ==# 'InsertCharPre'
    " Queue this key again
    call feedkeys(v:char)
    let v:char = ''
  else
    if a:event ==# 'BufNew'
      " For BufReadCmd plugins
      doautocmd <nomodeline> BufReadCmd
    endif
    if exists('#' . a:event) && prev_autocmd !=# new_autocmd
      execute 'doautocmd <nomodeline>' a:event
    elseif exists('#User#' . a:event)
      execute 'doautocmd <nomodeline> User' a:event
    endif
  endif
endfunction

function! plug#_on_func(name) abort
  let function_prefix = substitute(a:name, '[^#]*$', '', '')
  if function_prefix =~# '^plug#'
        \ || function_prefix =~# '^vital#'
        \ || has('vim_starting')
    return
  endif
  call plug#source(filter(plug#_get_lazy_plugins(),
        \  "stridx(function_prefix, v:val.normalized_name.'#') == 0
        \   || (index(get(v:val, 'on_func', []), a:name) >= 0)"))
endfunction

function! plug#begin(path, ...) abort
  if !exists('#plug')
    call plug#_init()
  endif

  " Reset variables
  let g:plug#_plugins = {}
  let g:plug#_event_plugins = {}
  let g:plug#_ftplugin = {}
  let g:plug#_hook_add = ''

  if !api#has_job()
    call api#error('Does not work in the Vim (' . v:version . ').')
    return 1
  endif

  if a:path ==# '' || g:plug#_block_level != 0
    call api#error('Invalid begin/end block usage.')
    return 1
  endif

  let g:plug#_block_level += 1
  let g:plug#_base_path = api#expand(a:path)
  if g:plug#_base_path[-1:] ==# '/'
    let g:plug#_base_path = g:plug#_base_path[: -2]
  endif
  call plug#_get_runtime_path()
  call plug#_get_cache_path()

  let vimrcs = empty(a:000) ? [] : a:1
  let g:plug#_vimrcs = plug#_get_vimrcs(vimrcs)

  " Filetype off
  if exists('g:did_load_filetypes') || has('nvim')
    let g:plug#_off1 = 'filetype off'
    execute g:plug#_off1
  endif
  if exists('b:did_indent') || exists('b:did_ftplugin')
    let g:plug#_off2 = 'filetype plugin indent off'
    execute g:plug#_off2
  endif

  if !has('vim_starting')
    execute 'set rtp-='.fnameescape(g:plug#_runtime_path)
    execute 'set rtp-='.fnameescape(g:plug#_runtime_path.'/after')
  endif

  " Insert dein runtimepath to the head in 'runtimepath'.
  let rtps = api#split_rtp(&runtimepath)
  let idx = index(rtps, $VIMRUNTIME)
  if idx < 0
    call api#error('Invalid runtimepath.')
    return 1
  endif
  if fnamemodify(a:path, ':t') ==# 'plugin'
        \ && index(rtps, fnamemodify(a:path, ':h')) >= 0
    call api#error('You must not set the installation directory'
          \ .' under "&runtimepath/plugin"')
    return 1
  endif
  call insert(rtps, g:plug#_runtime_path, idx)
  call api#add_after(rtps, g:plug#_runtime_path.'/after')
  let &runtimepath = api#join_rtp(rtps,
        \ &runtimepath, g:plug#_runtime_path)
endfunction

function! plug#end() abort
  if g:plug#_block_level != 1
    call api#error('Invalid begin/end block usage.')
    return 1
  endif
  let g:plug#_block_level -= 1
  if !has('vim_starting')
    call plug#source(filter(values(g:plug#_plugins),
       \ "!v:val.lazy && !v:val.sourced && v:val.rtp !=# ''"))
  endif
  " Add runtimepath
  let rtps = api#split_rtp(&runtimepath)
  let index = index(rtps, g:plug#_runtime_path)
  if index < 0
    call api#error('Invalid runtimepath.')
    return 1
  endif
  let depends = []
  let sourced = has('vim_starting') &&
        \ (!exists('&loadplugins') || &loadplugins)
  for plugin in filter(values(g:plug#_plugins),
        \ "!v:val.lazy && !v:val.sourced && v:val.rtp !=# ''")
    " Load dependencies
    if has_key(plugin, 'depends')
      let depends += plugin.depends
    endif
    if !plugin.merged
      call insert(rtps, plugin.rtp, index)
      if isdirectory(plugin.rtp.'/after')
        call api#add_after(rtps, plugin.rtp.'/after')
      endif
    endif
    let plugin.sourced = sourced
  endfor
  let &runtimepath = api#join_rtp(rtps, &runtimepath, '')
  if !empty(depends)
    call plug#source(depends)
  endif
  if g:plug#_hook_add !=# ''
    call plug#util#_execute_hook({}, g:plug#_hook_add)
  endif
  for [event, plugins] in filter(items(g:plug#_event_plugins),
        \ "exists('##' . v:val[0])")
    execute printf('autocmd dein-events %s call '
          \. 'plug#autoload#_on_event("%s", %s)',
          \ (exists('##' . event) ? event . ' *' : 'User ' . event),
          \ event, string(plugins))
  endfor
  if !has('vim_starting')
    call plug#call_hook('add')
    call plug#call_hook('source')
    call plug#call_hook('post_source')
  endif
endfunction

function! plug#_get_runtime_path() abort
  if g:plug#_runtime_path !=# ''
    return g:plug#_runtime_path
  endif

  let g:plug#_runtime_path = plug#_get_cache_path() . '/.dein'
  if !isdirectory(g:plug#_runtime_path)
    call mkdir(g:plug#_runtime_path, 'p')
  endif
  return g:plug#_runtime_path
endfunction

function! plug#_get_cache_path() abort
  if g:plug#_cache_path !=# ''
    return g:plug#_cache_path
  endif

  let g:plug#_cache_path = get(g:,
        \ 'plug#cache_directory', g:plug#_base_path)
        \ . '/.cache/' . fnamemodify(plug#_get_myvimrc(), ':t')
  if !isdirectory(g:plug#_cache_path)
    call mkdir(g:plug#_cache_path, 'p')
  endif
  return g:plug#_cache_path
endfunction

function! plug#_get_myvimrc() abort
  let vimrc = $MYVIMRC !=# '' ? $MYVIMRC :
        \ matchstr(split(api#redir('scriptnames'), '\n')[0],
        \  '^\s*\d\+:\s\zs.*')
  return api#substitute_path(vimrc)
endfunction

function! plug#_get_vimrcs(vimrcs) abort
  return !empty(a:vimrcs) ?
        \ map(api#convert2list(a:vimrcs), 'expand(v:val)') :
        \ [plug#_get_myvimrc()]
endfunction

function! plug#source(...) abort
  let plugins = empty(a:000) ? values(g:plug#_plugins) :
        \ api#convert2list(a:1)
  if empty(plugins)
    return
  endif
  if type(plugins[0]) != v:t_dict
    let plugins = map(api#convert2list(a:1),
        \       'get(g:plug#_plugins, v:val, {})')
  endif
  let rtps = api#split_rtp(&runtimepath)
  let index = index(rtps, plug#_get_runtime_path())
  if index < 0
    return 1
  endif
  let sourced = []
  for plugin in filter(plugins,
        \ "!empty(v:val) && !v:val.sourced && v:val.rtp !=# ''")
    call plug#source_plugin(rtps, index, plugin, sourced)
  endfor
  let filetype_before = api#redir('autocmd FileType')
  let &runtimepath = api#join_rtp(rtps, &runtimepath, '')
  call plug#call_hook('source', sourced)
  " Reload script files.
  for plugin in sourced
    for directory in filter(['plugin', 'after/plugin'],
          \ "isdirectory(plugin.rtp.'/'.v:val)")
      for file in api#globlist(plugin.rtp.'/'.directory.'/**/*.vim')
        execute 'source' fnameescape(file)
      endfor
    endfor
    if !has('vim_starting')
      let augroup = get(plugin, 'augroup', plugin.normalized_name)
      if exists('#'.augroup.'#VimEnter')
        silent execute 'doautocmd' augroup 'VimEnter'
      endif
      if has('gui_running') && &term ==# 'builtin_gui'
            \ && exists('#'.augroup.'#GUIEnter')
        silent execute 'doautocmd' augroup 'GUIEnter'
      endif
      if exists('#'.augroup.'#BufRead')
        silent execute 'doautocmd' augroup 'BufRead'
      endif
    endif
  endfor
  let filetype_after = api#redir('autocmd FileType')
  let is_reset = api#is_reset_ftplugin(sourced)
  if is_reset
    call api#reset_ftplugin()
  endif
  if (is_reset || filetype_before !=# filetype_after) && &filetype !=# ''
    " Recall FileType autocmd
    let &filetype = &filetype
  endif
  if !has('vim_starting')
    call plug#call_hook('post_source', sourced)
  endif
endfunction

function! plug#source_plugin(rtps, index, plugin, sourced) abort
  if a:plugin.sourced || index(a:sourced, a:plugin) >= 0
    return
  endif
  call add(a:sourced, a:plugin)
  let index = a:index
  " Load dependencies
  for name in get(a:plugin, 'depends', [])
    if !has_key(g:plug#_plugins, name)
      call api#error(printf(
            \ 'Plugin name "%s" is not found.', name))
      continue
    endif
    if !a:plugin.lazy && g:plug#_plugins[name].lazy
      call api#error(printf(
            \ 'Not lazy plugin "%s" depends lazy "%s" plugin.',
            \ a:plugin.name, name))
      continue
    endif
    if plug#source_plugin(a:rtps, index, g:plug#_plugins[name], a:sourced)
      let index += 1
    endif
  endfor
  let a:plugin.sourced = 1
  for on_source in filter(plug#_get_lazy_plugins(),
        \ "index(get(v:val, 'on_source', []), a:plugin.name) >= 0")
    if plug#source_plugin(a:rtps, index, on_source, a:sourced)
      let index += 1
    endif
  endfor
  if has_key(a:plugin, 'dummy_commands')
    for command in a:plugin.dummy_commands
      silent! execute 'delcommand' command[0]
    endfor
    let a:plugin.dummy_commands = []
  endif
  if has_key(a:plugin, 'dummy_mappings')
    for map in a:plugin.dummy_mappings
      silent! execute map[0].'unmap' map[1]
    endfor
    let a:plugin.dummy_mappings = []
  endif
  if !a:plugin.merged || get(a:plugin, 'local', 0)
    call insert(a:rtps, a:plugin.rtp, index)
    if isdirectory(a:plugin.rtp.'/after')
      call api#add_after(a:rtps, a:plugin.rtp.'/after')
    endif
  endif
endfunction

function! plug#_get_lazy_plugins() abort
  return filter(values(g:plug#_plugins),
        \ "!v:val.sourced && v:val.rtp !=# ''")
endfunction

function! plug#call_hook(hook_name, ...) abort
  let hook = 'hook_' . a:hook_name
  let plugins = filter(plug#_get_plugins((a:0 ? a:1 : [])),
        \ "((a:hook_name !=# 'source'
        \    && a:hook_name !=# 'post_source') || v:val.sourced)
        \   && has_key(v:val, hook) && isdirectory(v:val.path)")

  for plugin in filter(plug#_tsort(plugins),
        \ 'has_key(v:val, hook)')
    call plug#execute_hook(plugin, plugin[hook])
  endfor
endfunction

function! plug#_get_plugins(plugins) abort
  return empty(a:plugins) ?
        \ values(plug#get()) :
        \ filter(map(api#convert2list(a:plugins),
        \   'type(v:val) == v:t_dict ? v:val : plug#get(v:val)'),
        \   '!empty(v:val)')
endfunction

function! plug#get(...) abort
  return empty(a:000) ? copy(g:plug#_plugins) : get(g:plug#_plugins, a:1, {})
endfunction

function! plug#_tsort(plugins) abort
  let sorted = []
  let mark = {}
  for target in a:plugins
    call s:tsort_impl(target, mark, sorted)
  endfor
  return sorted
endfunction

function! s:tsort_impl(target, mark, sorted) abort
  if empty(a:target) || has_key(a:mark, a:target.name)
    return
  endif
  let a:mark[a:target.name] = 1
  if has_key(a:target, 'depends')
    for depend in a:target.depends
      call s:tsort_impl(plug#get(depend), a:mark, a:sorted)
    endfor
  endif
  call add(a:sorted, a:target)
endfunction

function! plug#execute_hook(plugin, hook) abort
  try
    let g:plug#plugin = a:plugin
    if type(a:hook) == v:t_string
      call s:execute(a:hook)
    else
      call call(a:hook, [])
    endif
  catch
    call api#error(
          \ 'Error occurred while executing hook: ' .
          \ get(a:plugin, 'name', ''))
    call api#error(v:exception)
  endtry
endfunction

function! s:execute(expr) abort
  if has('nvim')
    return execute(split(a:expr, '\n'))
  endif
  let dummy = '_dein_dummy_' .
        \ substitute(reltimestr(reltime()), '\W', '_', 'g')
  execute 'function! '.dummy."() abort\n"
        \ . a:expr . "\nendfunction"
  call {dummy}()
  execute 'delfunction' dummy
endfunction

function! plug#set_hook(plugins, hook_name, hook) abort
  let names = empty(a:plugins) ? keys(plug#get()) :
        \ api#convert2list(a:plugins)
  for name in names
    if !has_key(g:plug#_plugins, name)
      call api#error(name . ' is not found.')
      return 1
    endif
    let plugin = g:plug#_plugins[name]
    let plugin[a:hook_name] =
          \ type(a:hook) != v:t_string ? a:hook :
          \   substitute(a:hook, '\n\s*\\\|\%(^\|\n\)\s*"[^\n]*', '', 'g')
    if a:hook_name ==# 'hook_add'
      call plug#execute_hook(plugin, plugin[a:hook_name])
    endif
  endfor
endfunction
" vim: ft=vim ts=2 sw=2 et
