" ============================================================================
" File:        options.vim
" Description: options
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_options')
  finish
endif

set nocompatible
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030
set termencoding=cp936
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
set guioptions=grL
set helplang=cn
filetype plugin indent on
syntax on

try
    set gfn=Inziu_Iosevka_SC:h14:cANSI:qDRAFT
catch
    set gfn=Lucida_Console:h14:cANSI:qDRAFT
endtry

try
	colorscheme gruvbox
catch
	colorscheme desert
endtry

let g:vimtex_view_general_viewer = 'SumatraPDF.exe'

" ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir = $VIM . '/vimfiles/UltiSnips'

let g:loaded_options = 1

" vim: ft=vim ts=2 sw=2 et fenc=utf-8
