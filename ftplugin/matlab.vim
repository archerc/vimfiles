setlocal fenc=cp936
setlocal ts=4 sw=4 et
setlocal cms=\%\ %s

nnoremap <C-CR> <Plug>(toggle-comment)
vnoremap <C-CR> <Plug>(toggle-comment)

let g:matlab_auto_mappings = 0
let g:Matlab_MapLeader = '.'
let g:Matlab_LclTemplateFile = $HOME.'/vimfiles/matlab-support/templates/Templates'
let g:Matlab_GlbTemplateFile = expand($VIM . '/vimfiles/bundle/vim-plugins/matlab-support/templates/Templates')

hi matlabCellComment guifg=green 

