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
  " xnoremap  <Tab>       * :call UltiSnips#SaveLastVisualSelection()<CR>gvs
  " snoremap  <Tab>       * <Esc>:call UltiSnips#ExpandSnippet()<CR>

  if !hasmapto('<Plug>(edit-vimrc)')
    nmap     <Leader>v    <Plug>(edit-vimrc)
  endif
  if !hasmapto('<Plug>(list-marks)')
    nmap     <Leader>l    <Plug>(list-marks)
  endif
  if !hasmapto('<Plug>(copy-filepath)')
    nmap     <Leader>y    <Plug>(copy-filepath)
  endif
  if !hasmapto('<Plug>(list-buffer)')
    nmap     <Leader>b    <Plug>(list-buffer)
  endif
  if !hasmapto('<Plug>(easymotion-prefix)')
    nmap     <Leader>e    <Plug>(easymotion-prefix)
  endif
  if !hasmapto('<Plug>(unite-file)')
    nmap     <Leader>u    <Plug>(unite-file)
  endif
  if !hasmapto('<Plug>(unite-outline)')
    nmap     <Leader>o    <Plug>(unite-outline)
  endif
  if !hasmapto('<Plug>(open-terminal)')
    nmap     <Leader>t    <Plug>(open-terminal)
  endif
endfunction

function! s:define_mappings() abort
  nnoremap <Plug>(copy-filepath) :call <SID>copy_current_filepath()<CR>
  nnoremap <Plug>(edit-vimrc) :call <SID>edit_vimrc()<CR>
  nnoremap <Plug>(list-marks) :marks<CR>
  nnoremap <Plug>(open-terminal) :call <SID>open_terminal()<CR>
  if exists(':BufExplorer')
    nnoremap <Plug>(list-buffer)  :BufExplorer<CR>
  else
    nnoremap <Plug>(list-buffer)  :ls<CR>
  endif
  if exists(':Unite')
    nnoremap <Plug>(unite-file)   :Unite file_rec/async<CR>
    nnoremap <Plug>(unite-buffer)   :Unite buffer<CR>
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
  let vimrc = expand($VIM . '/vimfiles/plugin/init.vim')
  exe 'edit ' . vimrc
endfunction

call s:bind_keys()
autocmd events  VimEnter *  :call <SID>bind_keys()

call api#debug('keymap.vim loaded.')

let g:loaded_keymap = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
