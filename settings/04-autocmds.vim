augroup vim
	autocmd!
	autocmd FileType vim setlocal ts=2 sw=2
	autocmd BufWritePost *.vim :source %
	autocmd GUIEnter * colorscheme gruvbox
augroup END

augroup markdown
	autocmd!
	autocmd FileType pandoc setlocal conceallevel=0 ts=4 sw=4
	"autocmd BufWritePost *.md :AsyncRun -cwd=<root> make
augroup END

augroup matlab
	autocmd!
	autocmd FileType matlab setlocal ts=4 sw=4
augroup END

augroup fugitive
	autocmd! FileType fugitive inoremap <buffer> <C-Enter> <Esc>ZZ
	autocmd! FileType gitcommit inoremap <buffer> <C-Enter> <Esc>ZZ
augroup END

augroup tikz
	autocmd!
	autocmd! BufReadPost *.tikz let b:vimtex_main='tizkmain.tex'
augroup END
