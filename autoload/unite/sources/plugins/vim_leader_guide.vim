" ============================================================================
" File:        vim_leader_guide.vim
" Description: initliaze for plugin vim-leader-guide
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

"{{{ 初始化
function! unite#sources#plugins#vim_leader_guide#after_load() abort
	call unite#sources#plugins#vim_leader_guide#set_variables()
	call unite#sources#plugins#vim_leader_guide#define_mappings()
	call unite#sources#plugins#vim_leader_guide#bind_keys()
	echom 'vim leader guide initliazed.'
endfunction
	"}}}

"{{{ 设置变量
function! unite#sources#plugins#vim_leader_guide#set_variables() abort
	let g:mapleader = ' '
	" Define prefix dictionary
	let g:lmap =  { 'name' : '<Leader>' }
	" Second level dictionaries:
	let g:lmap.f = { 	'name' : 'File' }
	" Create new menus not based on existing mappings:
	let g:lmap.g = {
				\		'name' : 'Git',
				\		's' : ['Gstatus', 'Git Status'],
				\		'p' : ['Gpull',   'Git Pull'],
				\		'u' : ['Gpush',   'Git Push'],
				\		'c' : ['Gcommit', 'Git Commit'],
				\ }
	let g:lmap.o = { 'name' : 'open' }
	" Provide commands and descriptions for existing mappings
	let g:lmap.f.b = ['<Plug>(open-buffer-directory)', 'open buffer directory']
	let g:lmap.o.o = ['copen', 'Open quickfix']
	let g:lmap.o.l = ['lopen', 'Open locationlist']
	" If you use NERDCommenter:
	let g:lmap.c = { 'name' : 'Comments' }
	" Define some descriptions
	let g:lmap.c.c = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
	let g:lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
	" The Descriptions for other mappings defined by NerdCommenter, will default
	" to their respective commands.
	let g:maplocalleader = ','
	" set up dictionary for <localleader>
	let g:llmap = { 'name': '<localleader>' }
	autocmd FileType tex let g:llmap.l = { 'name' : 'vimtex' }
	call leaderGuide#register_prefix_descriptions(",", "g:llmap")
	" to name the <localleader>-n group vimtex in tex files.
	let g:leaderGuide_max_size = 5
	let g:leaderGuide_submode_mappings = { '<C-F>': 'page_down', '<C-B>': 'page_up'}
	" combine the two dictionaries into a single top-level dictionary:
	let g:topdict = { ' ': g:lmap, ',': g:llmap }
	" register it with the guide:
	call leaderGuide#register_prefix_descriptions("", "g:topdict")
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
    nnoremap <Plug>(open-buffer-directory) 	:VimFilerBufferDir<CR>
    nnoremap <Plug>(open-current-directory) :VimFilerCurrentDir<CR>
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
	nmap 			<silent> 	<Leader>d				<Plug>(delete-buffer)
	nmap 			<silent> 	<Leader>fb			<Plug>(open-buffer-directory)
	nmap 			<silent> 	<Leader>fc			<Plug>(open-current-directory)
	nmap 			<silent> 	<Leader>fd				<Plug>(current-directory)
	nmap 			<silent> 	<Leader>fe			<Plug>(open-explorer)
	nmap 			<silent> 	<Leader>fs			<Plug>(source-buffer)
	nmap 			<silent> 	<Leader>fw			<Plug>(write-buffer)
	nmap 			<silent> 	<Leader>l				<Plug>(list-marks)
	nnoremap 	<silent> 	<leader> 				:<c-u>LeaderGuide '<Space>'<CR>
	vnoremap 	<silent> 	<leader> 				:<c-u>LeaderGuideVisual '<Space>'<CR>
	map 			<silent> 	<leader>. 			<Plug>leaderguide-global
	nnoremap 						<localleader> 	:<c-u>LeaderGuide  ','<CR>
	vnoremap 						<localleader> 	:<c-u>LeaderGuideVisual  ','<CR>
	map 								<localleader>. 	<Plug>leaderguide-buffer
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
