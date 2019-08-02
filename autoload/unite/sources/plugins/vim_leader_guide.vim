" ============================================================================
" File:        vim_leader_guide.vim
" Description: initliaze for plugin vim-leader-guide
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

function! unite#sources#plugins#vim_leader_guide#after_load() abort "{{{ 初始化
	call unite#sources#plugins#vim_leader_guide#set_variables()
	call unite#sources#plugins#vim_leader_guide#define_mappings()
	call unite#sources#plugins#vim_leader_guide#bind_keys()
  return v:true
endfunction "}}}

function! unite#sources#plugins#vim_leader_guide#set_variables() abort "{{{ 设置变量
	let g:mapleader = ' '
	let lmap 			=  { 'name' : '<Leader>' }
	let lmap.a 		= { 'name' : 'Applications' }
	let lmap.a.t  = ['VimShell', 									'terminal']
	let lmap.a.s  = ['Startify', 									'startify']
	let lmap.a.f  = ['call ToggleFullScreen()', 	'fullscreen']
	let lmap.b 		= { 'name' : 'Buffer' }
	let lmap.b.d 	= ['bd!', 					'delete']
	let lmap.b.e 	= ['BufExplorer', 	'explorer']
	let lmap.b.n 	= ['bnext', 				'next']
	let lmap.b.p 	= ['bprev %', 			'previous']
	let lmap.b.s 	= ['source %', 			'source']
	let lmap.b.w 	= ['write', 				'write']
	let lmap.c 		= { 'name' : 'Comments' }
	" Define some descriptions
	let lmap.c.c 	= ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
	let lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
	let lmap.c.d 	= [ 'cd %:p:h', 		'current directory' ]
	let lmap.f 		= { 	'name' : 'File' }
	let lmap.f.b 	= ['VimFilerBufferDir', 	'buffer directory']
	let lmap.f.c 	= ['VimFilerCurrentDir', 'current directory']
	let lmap.f.e 	= ['VimFilerExplorer', 	'explorer']
	let lmap.f.f 	= ['VimFiler', 					'vimfiler']
	let lmap.f.s 	= ['Startify', 					'startify']
	let lmap.f.l 	= ['call unite#sources#plugins#vim_leader_guide#after_load()', 'reload']
	let lmap.g = { 	'name' : 'Git' }
  let lmap.g.c = ['Gcommit', 'Git Commit']
	let lmap.g.g = { 	'name' : 'GitGutter' }
  let lmap.g.m = ["call magit#show_magit('v')",   'Magit']
  let lmap.g.p = ['AsyncRun Git pull',   'Git Pull']
  let lmap.g.s = ['Gstatus', 'Git Status']
  let lmap.g.u = ['AsyncRun Git push',   'Git Push']
	let lmap.o = { 'name' : 'Open' }
	let lmap.o.o = ['copen', 'quickfix']
	let lmap.o.l = ['lopen', 'locationlist']
	let lmap.t = { 'name' : 'Toggle' }
	let lmap.t.b = ['ToggleBufExplorer',                      'buffer']
	let lmap.t.f = ['ToggleFullScreen',                       'fullscreen']
	let lmap.u = { 	'name': 'Unite' }
	let lmap.u.b = ['Unite -start-insert buffer',							'buffer']
	let lmap.u.d = ['Unite -start-insert neomru/directory',		'file']
	let lmap.u.f = ['Unite -start-insert neomru/file',				'file']
	let lmap.u.o = ['Unite -start-insert outline',						'outline']
	let lmap.u.s = ['Unite -start-insert source',							'source']
	" The Descriptions for other mappings defined by NerdCommenter, will default
	" to their respective commands.
	let g:maplocalleader = ','
	" set up dictionary for <localleader>
	let g:llmap = { 'name': '<localleader>' }
	autocmd FileType tex let g:llmap.l = { 'name' : 'vimtex' }
	" call leaderGuide#register_prefix_descriptions(",", "g:llmap")
	" to name the <localleader>-n group vimtex in tex files.
	let g:leaderGuide_max_size = 5
	let g:leaderGuide_submode_mappings = { '<C-F>': 'page_down', '<C-B>': 'page_up'}
	" combine the two dictionaries into a single top-level dictionary:
	let g:leaderGuide_map = { ' ': lmap, ',': g:llmap }
	" register it with the guide:
	call leaderGuide#register_prefix_descriptions("", "g:leaderGuide_map")
endfunction "}}}

function! unite#sources#plugins#vim_leader_guide#define_mappings() abort "{{{ 定义键映射
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

function! unite#sources#plugins#vim_leader_guide#bind_keys() abort "{{{ 绑定快捷键
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

