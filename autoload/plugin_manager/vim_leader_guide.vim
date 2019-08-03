" ============================================================================
" File:        vim_leader_guide.vim
" Description: initliaze for plugin vim-leader-guide
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================
if exists('g:loaded_autoload_plugin_manager_leaderGuide') && g:loaded_autoload_plugin_manager_leaderGuide
  finish
endif
let g:loaded_autoload_plugin_manager_leaderGuide = 1

let g:mapleader = ' '
let g:maplocalleader = ','
let g:leaderGuide_max_size = 5
let g:leaderGuide_submode_mappings = { '<C-F>': 'page_down', '<C-B>': 'page_up'}
" combine the two dictionaries into a single top-level dictionary:
let g:topdict = { ' ': {}, ',': {} }
let g:topdict[' '] 			=  { 'name' : '<Leader>' }
let g:topdict[' '].a 		= { 'name' : 'Applications' }
let g:topdict[' '].a.t  = ['VimShell', 									'terminal']
let g:topdict[' '].a.s  = ['Startify', 									'startify']
let g:topdict[' '].a.f  = ['call ToggleFullScreen()', 	'fullscreen']
let g:topdict[' '].b 		= { 'name' : 'Buffer' }
let g:topdict[' '].b.d 	= ['bd!', 					'delete']
let g:topdict[' '].b.e 	= ['BufExplorer', 	'explorer']
let g:topdict[' '].b.n 	= ['bnext', 				'next']
let g:topdict[' '].b.p 	= ['bprev %', 			'previous']
let g:topdict[' '].b.s 	= ['source %', 			'source']
let g:topdict[' '].b.w 	= ['write', 				'write']
let g:topdict[' '].c 		= { 'name' : 'Comments' }
" Define some descriptions
let g:topdict[' '].c.c 	= ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
let g:topdict[' '].c[' '] = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
let g:topdict[' '].c.d 	= [ 'cd %:p:h', 		'current directory' ]
let g:topdict[' '].f 		= { 	'name' : 'File' }
let g:topdict[' '].f.b 	= ['VimFilerBufferDir', 	'buffer directory']
let g:topdict[' '].f.c 	= ['VimFilerCurrentDir', 'current directory']
let g:topdict[' '].f.e 	= ['VimFilerExplorer', 	'explorer']
let g:topdict[' '].f.f 	= ['VimFiler', 					'vimfiler']
let g:topdict[' '].f.s 	= ['Startify', 					'startify']
let g:topdict[' '].f.l 	= ['call plugin_manager#vim_leader_guide#after_load()', 'reload']
let g:topdict[' '].g = { 	'name' : 'Git' }
let g:topdict[' '].g.c = ['Gcommit', 'Git Commit']
let g:topdict[' '].g.g = { 	'name' : 'GitGutter' }
let g:topdict[' '].g.m = ["call magit#show_magit('v')",   'Magit']
let g:topdict[' '].g.p = ['AsyncRun Git pull',   'Git Pull']
let g:topdict[' '].g.s = ['Gstatus', 'Git Status']
let g:topdict[' '].g.u = ['AsyncRun Git push',   'Git Push']
let g:topdict[' '].o = { 'name' : 'Open' }
let g:topdict[' '].o.o = ['copen', 'quickfix']
let g:topdict[' '].o.l = ['lopen', 'locationlist']
let g:topdict[' '].t = { 'name' : 'Toggle' }
let g:topdict[' '].t.b = ['ToggleBufExplorer',                      'buffer']
let g:topdict[' '].t.f = ['ToggleFullScreen',                       'fullscreen']
let g:topdict[' '].u = { 	'name': 'Unite' }
let g:topdict[' '].u.b = ['Unite -start-insert buffer',							'buffer']
let g:topdict[' '].u.d = ['Unite -start-insert neomru/directory',		'file']
let g:topdict[' '].u.f = ['Unite -start-insert neomru/file',				'file']
let g:topdict[' '].u.o = ['Unite -start-insert outline',						'outline']
let g:topdict[' '].u.s = ['Unite -start-insert source',							'source']
let g:topdict[','] = { 'name': '<localleader>' }

function! plugin_manager#vim_leader_guide#before_load() abort "{{{ 初始化
  echom 'loading vim_leader_guide '
  return v:true
endfunction "}}}

function! plugin_manager#vim_leader_guide#after_load() abort "{{{ 初始化
  " register it with the guide:
	autocmd FileType tex let g:topdict[','].l = { 'name' : 'vimtex' }
	call leaderGuide#register_prefix_descriptions("", "g:topdict")
	call s:define_mappings()
	call s:bind_keys()
  return v:true
endfunction "}}}

function! s:define_mappings() abort "{{{ 定义键映射
  nnoremap <Plug>(list-marks) :marks<CR>
  nnoremap <Plug>(current-directory) :cd %:p:h<CR>
  nnoremap <Plug>(delete-buffer)  :bd!<CR>
  nnoremap <Plug>(source-buffer)  :source %<CR>
  nnoremap <Plug>(write-buffer)   :w! %<CR>
  nnoremap <Plug>(open-quickfix)  :copen<CR>
  nnoremap <Plug>(open-locations) :lopen<CR>
  nnoremap <Plug>(toggle-fold)    :exec 'normal ' . (foldclosed('.')>0?'zo':'zc')<CR>
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
  if exists(':VimFilerExplorer')
    nnoremap <Plug>(open-explorer) :VimFilerExplorer<CR>
  endif
  if exists(':Startify')
    nnoremap <Plug>(startify) :Startify<CR>
  endif
  if exists(':Gstatus')
    nnoremap <Plug>(git-status) :Gstatus<CR>
		nnoremap <Plug>(git-pull) 	:Gpull<CR>
		nnoremap <Plug>(git-push)		:Gpush<CR>
		nnoremap <Plug>(git-commit)	:Gcommit<CR>
	endif
	if exists(':Unite')
		nnoremap <Plug>(unite-source)   :Unite source<CR>
		nnoremap <Plug>(unite-buffer)   :Unite -start-insert buffer<CR>
		nnoremap <Plug>(unite-file)     :Unite -start-insert file_rec<CR>
		nnoremap <Plug>(unite-history)  :Unite -start-insert file_mru directory_mru<CR>
		nnoremap <Plug>(unite-outline)  :Unite outline<CR>
	endif
	nnoremap 	<Plug>(leaderguide-global) 	:LeaderGuide g:mapleader<CR>
	nnoremap 	<Plug>(leaderguide-local) 	:LeaderGuide g:maplocalleader<CR>
endfunction "}}}

function! s:bind_keys() abort "{{{ 绑定快捷键
  nnoremap <C-s>   :w!<cr>
  nnoremap ]f :next<CR>
  nnoremap [f :prev<CR>
  nnoremap ]b :bnext<CR>
  nnoremap [b :bprev<CR>
  nnoremap ]w :wnext<CR>
  nnoremap [w :wprev<CR>
  nnoremap ]t :tnext<CR>
  nnoremap [t :tprev<CR>
  nmap 			<silent> 	<Leader>fd			<Plug>(current-directory)
  nmap 			<silent> 	<Leader>fl			<Plug>(list-marks)
  nmap 			<silent> 	<Leader>gg]			<Plug>GitGutterNextHunk
  nmap 			<silent> 	<Leader>gg[			<Plug>GitGutterPrevHunk
  nmap 			<silent> 	<Leader>ggp			<Plug>GitGutterPreviewHunk
  nmap 			<silent> 	<Leader>ggs			<Plug>GitGutterStageHunk
  nmap 			<silent> 	<Leader>ggu			<Plug>GitGutterUndoHunk
  nmap 			<silent> 	<Leader>tf 			<Plug>(toggle-fold)
  nnoremap 	<silent> 	<leader> 				:<c-u>LeaderGuide '<Space>'<CR>
  vnoremap 	<silent> 	<leader> 				:<c-u>LeaderGuideVisual '<Space>'<CR>
  map 			<silent> 	<leader>. 			<Plug>leaderguide-global
  nnoremap 						<localleader> 	:<c-u>LeaderGuide  ','<CR>
  vnoremap 						<localleader> 	:<c-u>LeaderGuideVisual  ','<CR>
  map 								<localleader>. 	<Plug>leaderguide-buffer
endfunction "}}}

function! s:copy_current_filepath() abort "{{{ 
  let @+ = expand('%:p')
endfunction "}}}

function! s:edit_vimrc() abort "{{{ 
  let vimrc = expand($VIM . '/vimfiles/plugin')
  exe 'edit ' . vimrc
endfunction "}}}

