set nocompatible
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030
set termencoding=cp936
"set lines=35 columns=158
set number
set ruler
set showcmd
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
	set gfn=Inziu_Iosevka_SC:h14:cANSI:qDRAFT
	echom g:init_file . ' not found'
endif

