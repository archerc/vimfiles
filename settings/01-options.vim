set nocompatible
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030
set termencoding=cp936
set lines=60 columns=90
set number
set ruler
set showcmd
set showtabline=1
set relativenumber
set colorcolumn=80
set background=dark
set noswapfile
set guioptions-=T
try
	colorscheme gruvbox
	set guifont=Inziu_Iosevka_SC:h14:cANSI:qDRAFT
catch
	colorscheme desert
	set guifont=Consolas_for_Powerline_FixedD:h14:cANSI:qDRAFT
endtry
hi ColorColumn guibg=#440000
