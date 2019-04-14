try
	py3 import vim
	let g:UltiSnipsUsePythonVersion = 3
	let g:_uspy = ':python3'
catch
	try
		py import vim
		let g:UltiSnipsUsePythonVersion = 2
	catch
		echo 'python can not enabled'
	endtry
endtry

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
 
" The default value for g:UltiSnipsJumpBackwardTrigger interferes with the 
" built-in complete function: |i_CTRL-X_CTRL-K|. A workaround is to add the 
" following to your vimrc file or switching to a plugin like Supertab or 
" YouCompleteMe. 
" inoremap <c-x><c-k> <c-x><c-k>

augroup pandoc
	autocmd FileType pandoc :UltiSnipsAddFiletypes pandoc.tex
augroup END
