setlocal tabstop=2
setlocal shiftwidth=2
setlocal fdm=marker
setlocal cms=\ \"%s

augroup vim_filetype
	autocmd!
	autocmd BufReadPost 	*.vim,vimrc,_vimrc :setlocal cms=\ \"%s
	autocmd BufWritePost 	*.vim,vimrc,_vimrc :source <sfile>
augroup END
