" 系统默认配置文件
""" Options
set guifont=Iosevka_Term:h14:cANSI:qDRAFT
set number
set relativenumber

""" Keys
nnoremap	<C-s>	:w<CR>
inoremap	<C-s>	<Esc>:w<CR>
nnoremap	<F5>	<Esc>:source %<CR>

""" AutoCommands
augroup vim_filetype
    autocmd!
    autocmd FileType  	vim 	    :call OnVimScript(expand('<afile>'))
augroup END

augroup events
    autocmd!
    autocmd BufWritePost 	vimrc,*.vim 	:call OnVimScriptModified(expand('<afile>'))
    autocmd BufWritePost    *   :call OnModified(expand('<afile>'))
augroup END

""" Functions
function! OnVimScript(file)
    setlocal tabstop=4 shiftwidth=4 expandtab
    exe 'nnoremap <buffer> <F5>	:source ' . a:file . '<CR>'
endfunction

function! OnVimScriptModified(file)
    echom 'OnVimScriptModified'
    execute 'source ' . a:file 
    echom a:file . ' is loaded'
endfunction

function! OnModified(file)
    " echom 'OnModified'
    echom a:file . ' is saved'
endfunction

" vim: set fdm=marker ft=vim expandtab ts=4 sw=4
