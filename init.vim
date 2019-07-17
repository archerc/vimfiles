" ============================================================================
" File:        init.vim
" Description: vimrc
" Author:      archerC <brightcxl@gmail.com>
" Website:     https://github.com/archerC
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

""" Options
set number
set relativenumber

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
augroup END

" vim: ft=vim ts=2 sw=2 et fdm=marker 
