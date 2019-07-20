" ============================================================================
" File:        autocommands.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if exists('g:loaded_autocmds') && g:loaded_autocmds
  finish
endif

""" AutoCommands
augroup vim_filetype
    autocmd!
    autocmd FileType  	vim 	    :call on#VimScript(expand('<afile>'))
augroup END

augroup events
    autocmd!
    autocmd BufWritePost 	vimrc,*.vim 	:call on#VimScriptModified(expand('<afile>'))
    autocmd VimEnter      *   :call pathogen#infect()
    autocmd VimEnter      *   :call on#VimEnter()
    autocmd GuiEnter      *   :call on#GuiEnter()
augroup END

let g:loaded_autocmds = 1

" vim: ft=vim ts=2 sw=2 et fdm=marker 
