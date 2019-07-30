" ============================================================================
" File:        keymap.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_keymap') && g:loaded_keymap
  finish
endif

" Define prefix dictionary
let g:lmap =  {}
" Second level dictionaries:
let g:lmap.f = { 'name' : 'File Menu' }
" Provide commands and descriptions for existing mappings
let g:lmap.f.d = ['<Plug>(edit-vimrc)', 'edit vimrc']
let g:lmap.f.s = ['<Plug>(source-buffer)', 'source buffer']
let g:lmap.f.w = ['<Plug>(write-buffer)', 'write file']

let g:lmap.o = { 'name' : 'Open Stuff' }
let g:lmap.o.o = ['<Plug>(open-quickfix)', 'open quickfix']
let g:lmap.o.l = ['<Plug>(open-locations)', 'open locationlist']

" Create new menus not based on existing mappings:
let g:lmap.g = {
      \'name' : 'Git Menu',
      \'s' : ['Gstatus', 'Git Status'],
      \'p' : ['Gpull',   'Git Pull'],
      \'u' : ['Gpush',   'Git Push'],
      \'c' : ['Gcommit', 'Git Commit'],
      \'w' : ['Gwrite',  'Git Write'],
      \}

" If you use NERDCommenter:
let g:lmap.c = { 'name' : 'Comments' }
" Define some descriptions
let g:lmap.c.c = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
let g:lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
" The Descriptions for other mappings defined by NerdCommenter, will default
" to their respective commands.

if exists('loaded_leaderGuide_vim')
  call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
  nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
  vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
end

function! s:bind_keys() abort
  call s:define_mappings()
  let g:mapleader = ','
  nnoremap  <C-s>   :w!<cr>
  nnoremap ]f :next<CR>
  nnoremap [f :prev<CR>
  nnoremap ]b :bnext<CR>
  nnoremap [b :bprev<CR>
  nnoremap ]w :wnext<CR>
  nnoremap [w :wprev<CR>
  nnoremap ]t :tnext<CR>
  nnoremap [t :tprev<CR>
  if !hasmapto('<Plug>(unite-buffer)')
    nmap     <Leader>b    <Plug>(unite-buffer)
  endif
  if !hasmapto('<Plug>(list-buffer)')
    nmap     <Leader>B    <Plug>(list-buffer)
  endif
  if !hasmapto('<Plug>(unite-buffer)')
    nmap     <Leader>B    <Plug>(unite-buffer)
  endif
  if !hasmapto('<Plug>(current-directory)')
    nmap     <Leader>c    <Plug>(current-directory)
  endif
  if !hasmapto('<Plug>(delete-buffer)')
    nmap     <Leader>d    <Plug>(delete-buffer)
  endif
  if !hasmapto('<Plug>(easymotion-prefix)')
    nmap     <Leader>e    <Plug>(easymotion-prefix)
  endif
  if !hasmapto('<Plug>(unite-file)')
    nmap     <Leader>f    <Plug>(unite-file)
  endif
  if !hasmapto('<Plug>(find-file)')
    nmap     <Leader>F    <Plug>(find-file)
  endif
  if !hasmapto('<Plug>(git-status)')
    nmap     <Leader>g    <Plug>(git-status)
  endif
  if !hasmapto('<Plug>(bind-keys)')
    nmap     <Leader>k    <Plug>(bind-keys)
  endif
  if !hasmapto('<Plug>(list-marks)')
    nmap     <Leader>l    <Plug>(list-marks)
  endif
  if !hasmapto('<Plug>(do-make)')
    nmap     <Leader>m    <Plug>(do-make)
  endif
  if !hasmapto('<Plug>(unite-outline)')
    nmap     <Leader>o    <Plug>(unite-outline)
  endif
  if !hasmapto('<Plug>(load-plugins)')
    nmap     <Leader>p    <Plug>(load-plugins)
  endif
  if !hasmapto('<Plug>(unite-history)')
    nmap     <Leader>r    <Plug>(unite-history)
  endif
  if !hasmapto('<Plug>(open-explorer)')
    nmap     <Leader>R    <Plug>(open-explorer)
  endif
  if !hasmapto('<Plug>(source-buffer)')
    nmap     <Leader>s    <Plug>(source-buffer)
  endif
  if !hasmapto('<Plug>(open-terminal)')
    nmap     <Leader>t    <Plug>(open-terminal)
  endif
  if !hasmapto('<Plug>(unite-source)')
    nmap     <Leader>u    <Plug>(unite-source)
  endif
  if !hasmapto('<Plug>(edit-vimrc)')
    nmap     <Leader>v    <Plug>(edit-vimrc)
  endif
  if !hasmapto('<Plug>(startify)')
    nmap     <Leader>x    <Plug>(startify)
  endif
  if !hasmapto('<Plug>(copy-filepath)')
    nmap     <Leader>y    <Plug>(copy-filepath)
  endif
endfunction
command BindKeys call s:bind_keys()

function! s:define_mappings() abort
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
  else
    nnoremap <Plug>(open-terminal) :call <SID>open_terminal()<CR>
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
    nnoremap <Plug>(unite-history)     :Unite -start-insert file_mru directory_mru<CR>
    nnoremap <Plug>(unite-outline)   :Unite outline<CR>
  endif
endfunction

""" functions
let g:term_options = {}
let g:term = 0
function! s:open_terminal(...) abort
  if g:term > 0 && !empty(bufname(g:term))
    exe 'buffer ' . g:term
  else
    if empty(a:000)
      let cmd = 'cmd'
    else
      let cmd = a:1
    endif
    let options = g:term_options
    if !has_key(options, 'cwd')
      let options.cwd = expand('%:p:h')
    endif
    let g:term = term_start(cmd, options)
  endif
endfunction

function! s:copy_current_filepath() abort
  let @+ = expand('%:p')
endfunction

function! s:edit_vimrc() abort
  let vimrc = expand($VIM . '/vimfiles/plugin')
  exe 'edit ' . vimrc
endfunction

augroup keymap
  autocmd!
  autocmd VimEnter *  :BindKeys
  autocmd BufWritePost <buffer> :source <sfile>
augroup END

" let g:loaded_keymap = 0

" vim: ft=vim et fdm=marker 
