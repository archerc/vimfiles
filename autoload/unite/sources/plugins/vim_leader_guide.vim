" ============================================================================
" File:        vim_leader_guide.vim
" Description: initliaze for plugin vim-leader-guide
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

"{{{ 初始化
function! unite#sources#plugins#vim_leader_guide#on_init() abort
	call unite#sources#plugins#vim_leader_guide#set_variables()
	call unite#sources#plugins#vim_leader_guide#define_mappings()
	call unite#sources#plugins#vim_leader_guide#bind_keys()
endfunction
"}}}

"{{{ 设置变量
function! unite#sources#plugins#vim_leader_guide#set_variables() abort
  let g:mapleader = ' '
  let g:maplocalleader = ','
	" Define prefix dictionary
	let g:leaderGuide_map =  {
				\ 	'f': {
				\ 					'name': 'File Menu',
				\ 					'b'		: ['VimFilerBufferDir', 'vimfiler-buffer'],
				\ 					'c'		: ['VimFilerCurrentDir', 'vimfiler-current'],
				\ 					'e'		: ['VimFilerExplorer', 'vimfiler-explorer'],
				\ 					's'		: ['source %', 'source buffer'],
				\ 					'w'		: ['write', 'save file'],
				\ 			 },
				\ 	'g': {
				\						'name': 'Git Menu',
				\						's' 	: ['Gstatus', 'Git Status'],
				\						'p' 	: ['Gpull',   'Git Pull'],
				\						'u' 	: ['Gpush',   'Git Push'],
				\						'c' 	: ['Gcommit', 'Git Commit'],
				\						'w' 	: ['Gwrite',  'Git Write'],
				\				},
				\ }
	" " Second level dictionaries:
	" let g:lmap.f = { 'name' : 'File Menu' }
	" " Provide commands and descriptions for existing mappings
	" let g:lmap.o = { 'name' : 'Open Stuff' }
	" let g:lmap.o.o = ['<Plug>(open-quickfix)', 'open quickfix']
	" let g:lmap.o.l = ['<Plug>(open-locations)', 'open locationlist']
	" " Create new menus not based on existing mappings:
	" " If you use NERDCommenter:
	" let g:lmap.c = { 'name' : 'Comments' }
	" " Define some descriptions
	" let g:lmap.c.c = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
	" let g:lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
	" The Descriptions for other mappings defined by NerdCommenter, will default
	" to their respective commands.
endfunction
"}}}

"{{{ 定义键映射
function! unite#sources#plugins#vim_leader_guide#define_mappings() abort
  nnoremap <Plug>(list-marks) :marks<CR>
  nnoremap <Plug>(current-directory) :cd %:p:h<CR>
  nnoremap <Plug>(delete-buffer)  :bd!<CR>
  nnoremap <Plug>(source-buffer)  :source %<CR>
  nnoremap <Plug>(write-buffer)   :w! %<CR>
  nnoremap <Plug>(open-quickfix)  :copen<CR>
  nnoremap <Plug>(open-locations) :lopen<CR>
  " by functions
  nnoremap <Plug>(copy-filepath) :call <SID>copy_current_filepath()<CR>
  nnoremap <Plug>(edit-vimrc) :call <SID>edit_vimrc()<CR>
  if exists(':VimShell')
    nnoremap <Plug>(open-terminal) :VimShell<CR>
  endif
  nnoremap <Plug>(bind-keys) :call <SID>bind_keys()<CR>
  if exists(':BufExplorer')
    nnoremap <Plug>(list-buffer)  :BufExplorer<CR>
  else
    nnoremap <Plug>(list-buffer)  :ls<CR>
  endif
  if exists(':Make')
    nnoremap <Plug>(do-make)  :Make<CR>
  else
    nnoremap <Plug>(do-make)  :make<CR>
  endif
  if exists(':VimFilerBufferDir')
    nnoremap <Plug>(find-file) :VimFilerBufferDir<CR>
  else
    nnoremap <Plug>(find-file) :edit . <CR>
  endif
  if exists(':VimFilerExplorer')
    nnoremap <Plug>(open-explorer) :VimFilerExplorer<CR>
  endif
  if exists(':Startify')
    nnoremap <Plug>(startify) :Startify<CR>
  endif
  if exists(':Gstatus')
    nnoremap <Plug>(git-status) :Gstatus<CR>
  endif
  if exists(':Unite')
    nnoremap <Plug>(unite-source)   :Unite source<CR>
    nnoremap <Plug>(unite-buffer)   :Unite -start-insert buffer<CR>
    nnoremap <Plug>(unite-file)     :Unite -start-insert file_rec<CR>
    nnoremap <Plug>(unite-history)  :Unite -start-insert file_mru directory_mru<CR>
    nnoremap <Plug>(unite-outline)  :Unite outline<CR>
  endif
	nnoremap 	<Plug>(leaderguide-global) 	:LeaderGuideD g:leaderGuide_map<CR>
	nnoremap 	<Plug>(leaderguide-local) 	:LeaderGuideD b:leaderGuide_map<CR>
endfunction
"}}}

"{{{ 绑定快捷键
function! unite#sources#plugins#vim_leader_guide#bind_keys() abort
  nnoremap <C-s>   :w!<cr>
  nnoremap ]f :next<CR>
  nnoremap [f :prev<CR>
  nnoremap ]b :bnext<CR>
  nnoremap [b :bprev<CR>
  nnoremap ]w :wnext<CR>
  nnoremap [w :wprev<CR>
  nnoremap ]t :tnext<CR>
  nnoremap [t :tprev<CR>
	nmap <silent> <Leader> <Plug>(leaderguide-global)
	nmap <silent> <LocalLeader> <Plug>(leaderguide-local)
	" nmap <silent> <Leader> <Plug>leaderguide-global
	" nmap <silent> <LocalLeader> <Plug>leaderguide-buffer
endfunction
"}}}

"{{{ 定义函数: copy_current_filepath
function! s:copy_current_filepath() abort
  let @+ = expand('%:p')
endfunction
"}}}

"{{{ 定义函数: edit_vimrc
function! s:edit_vimrc() abort
  let vimrc = expand($VIM . '/vimfiles/plugin')
  exe 'edit ' . vimrc
endfunction
"}}}

" vim: fdm=marker
