augroup vim
	autocmd!
	autocmd FileType vim setlocal ts=2 sw=2
	autocmd BufWritePost *.vim :source %
augroup END

augroup markdown
	autocmd!
	autocmd FileType pandoc setlocal conceallevel=0 ts=4 sw=4
	autocmd BufWritePost *.md :AsyncRun -cwd=<root> make
augroup END

