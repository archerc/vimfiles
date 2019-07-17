" ============================================================================
" File:        init.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

""" Options
set laststatus=2
set number
set relativenumber
filetype plugin indent on
""" Keys
call api#BindKeys()

""" AutoCommands
augroup vim_filetype
    autocmd!
    autocmd FileType  	vim 	    :call on#VimScript(expand('<afile>'))
augroup END

augroup events
    autocmd!
    autocmd BufWritePost 	vimrc,*.vim 	:call on#VimScriptModified(expand('<afile>'))
    autocmd BufWritePost  *   :call on#Modified(expand('<afile>'))
    autocmd VimEnter      *   :call on#VimEnter()
    autocmd GuiEnter      *   :call on#GuiEnter()
augroup END

let vimrc = vimrc#load($VIM . '/vimfiles/init.json')

" vim: ft=vim ts=2 sw=2 et fdm=marker 
