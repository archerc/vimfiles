""""""""""""""""""""""""""""""""""""""
""" airline

" let g:airline_theme="default" 
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
"set guifont="Consolas for Powerline FixedD:h14"

" let g:airline_powerline_fonts = 1
" let g:airline_theme='papercolor'
" let g:airline#extensions#tabline#show_tab_nr = 1
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#tabs_label = 't'
" let g:airline#extensions#tabline#buffers_label = 'b'

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


" let airline_extensions_not_installed = [
" 			\  'capslock'
" 			\, 'commandt'
" 			\, 'csv'
" 			\, 'ctrlp'
" 			\, 'ctrlspace'
" 			\, 'default'
" 			\, 'eclim'
" 			\, 'example'
" 			\, 'fugitiveline'
" 			\, 'grepper'
" 			\, 'gutentags'
" 			\, 'localsearch'
" 			\, 'neomake'
" 			\, 'nrrwrgn'
" 			\, 'obsession'
" 			\, 'promptline'
" 			\, 'syntastic'
" 			\, 'tagbar'
" 			\, 'tmuxline'
" 			\, 'undotree'
" 			\, 'unicode'
" 			\, 'windowswap'
" 			\, 'xkblayout'
" 			\]
" 
" let g:available_airline_extensions = [ 
" 			\  'ale'
" 			\, 'branch'
" 			\, 'bufferline'
" 			\, 'capslock'
" 			\, 'commandt'
" 			\, 'csv'
" 			\, 'ctrlp'
" 			\, 'ctrlspace'
" 			\, 'cursormode'
" 			\, 'default'
" 			\, 'denite'
" 			\, 'eclim'
" 			\, 'example'
" 			\, 'fugitiveline'
" 			\, 'grepper'
" 			\, 'gutentags'
" 			\, 'hunks'
" 			\, 'keymap'
" 			\, 'languageclient'
" 			\, 'localsearch'
" 			\, 'neomake'
" 			\, 'netrw'
" 			\, 'nrrwrgn'
" 			\, 'obsession'
" 			\, 'po'
" 			\, 'promptline'
" 			\, 'quickfix'
" 			\, 'syntastic'
" 			\, 'tabline'
" 			\, 'tagbar'
" 			\, 'term'
" 			\, 'tmuxline'
" 			\, 'undotree'
" 			\, 'unicode'
" 			\, 'unite'
" 			\, 'vimagit'
" 			\, 'vimtex'
" 			\, 'virtualenv'
" 			\, 'whitespace'
" 			\, 'windowswap'
" 			\, 'wordcount'
" 			\, 'xkblayout'
" 			\, 'ycm'
" 			\]
" 
let g:airline_extensions = [ 'tabline' ]
let g:airline_statusline_ontop = 1
" let g:airline_extensions = [ 
" 			\  'ale'
" 			\, 'branch'
" 			\, 'bufferline'
" 			\, 'cursormode'
" 			\, 'denite'
" 			\, 'hunks'
" 			\, 'keymap'
" 			\, 'languageclient'
" 			\, 'netrw'
" 			\, 'po'
" 			\, 'quickfix'
" 			\, 'tabline'
" 			\, 'term'
" 			\, 'unite'
" 			\, 'vimagit'
" 			\, 'vimtex'
" 			\, 'virtualenv'
" 			\, 'whitespace'
" 			\, 'wordcount'
" 			\, 'ycm'
" 			\]
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" vim-bufferline
let g:bufferline_echo = 1
autocmd VimEnter *
			\ let &statusline='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()
""""""""""""""""""""""""""""""""""""""

