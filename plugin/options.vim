" ============================================================================
" File:        options.vim
" Description: options
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:did_plugin_options')
  finish
endif
" Options {{{
set nocompatible
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030
set lines=45 columns=80
set number
set ruler
set showcmd
set cmdheight=2
set showtabline=1
set relativenumber
set colorcolumn=80
set background=dark
set noswapfile
set hls
set guioptions=grL
set helplang=cn
filetype plugin indent on
syntax on
" }}}
" function: SetFont() {{{
function! SetFont() abort
  try
    set gfn=Inziu_Iosevka_SC:h14:cANSI:qDRAFT
  catch
    set gfn=Lucida_Console:h14:cANSI:qDRAFT
  endtry
endfunction
" }}}
" function: SetColor() {{{
function! SetColor() abort
  try
    colorscheme gruvbox
  catch
    colorscheme desert
  endtry
endfunction
" }}}
" autocommands:  {{{
augroup vim_options
  au!
  au VimEnter * call SetFont()
  au VimEnter * call SetColor()
augroup END
" }}}
" variables: {{{
let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
" let g:Matlab_GlbTemplateFile = 
" }}}
let g:did_plugin_options = 1

