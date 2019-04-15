" vim: ft=vim ts=2 sw=2 fileencoding=utf-8
""""""""""""""""""""""""""""""""""""""
""" airline
let g:airline_theme="dark" 
" let g:airline_theme="molokai" 
" let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
	let g:airline_symbols.branch = '⭠'
	let g:airline_symbols.readonly = '⭤'
endif

let g:airline_statusline_ontop = 0

""""""""""""""""""""""""""""""""""""""
let g:airline_extensions = [ 
			\  'ale'
			\, 'branch'
			\, 'bufferline'
			\, 'hunks'
			\, 'keymap'
			\, 'languageclient'
			\, 'tabline'
			\, 'whitespace'
			\, 'ycm'
			\]

call airline#extensions#load()
call airline#extensions#load_theme()
