setlocal tabstop=2
setlocal shiftwidth=2
setlocal fdm=marker

augroup vim_filetype
	autocmd!
	autocmd BufWritePost *.vim,vimrc,_vimrc :source <sfile>
augroup END
