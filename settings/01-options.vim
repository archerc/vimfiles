set nocompatible
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030
set termencoding=cp936
set lines=35 columns=140
set number
set ruler
set showcmd
set cmdheight=2
set showtabline=1
set relativenumber
set colorcolumn=80
set background=dark
set noswapfile
set guioptions=grL
try
	colorscheme gruvbox
catch
	colorscheme desert
endtry
hi ColorColumn guibg=#440000
if !exists('g:init_file')
	let g:init_file = expand('<sfile>:h') . '\init.json'
endif
if filereadable(g:init_file)
	let options = json_decode(join(readfile(g:init_file)))
	for [k,v] in items(options)
		exe 'set '. k . '=' . v
	endfor
else
	echom g:init_file . ' not found'
endif

