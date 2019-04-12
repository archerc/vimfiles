" vim: ts=2 sw=2 ft=vim et
" Defaults
let g:leaderGuide_run_map_on_popup = 1
let g:leaderGuide_hspace = 5
let g:leaderGuide_vertical = 0
let g:leaderGuide_position = 'botright'
let g:leaderGuide_map = {
      \   ' ':  {
      \           'name': '<Leader>' 
      \           ,  'g': {
      \                     'name': 'Git Menu',
      \                     '<C-I>' : ['Gstatus', 'Git Status'],
      \                     '<BS>'  : ['Gpull',   'Git Pull'],
      \                     '<C-P>' : ['Gpush',   'Git Push'],
      \                     '/'     : ['Gcommit', 'Git Commit'],
      \                     '<F4>'  : ['Gwrite',  'Git Write'],
      \                   }
      \           ,  'f': {
      \                     'name': 'File Menu',
      \                   }
      \         }
      \ , ',':  {
      \           'name': '<LocalLeader>' 
      \         }
      \ }
if exists('leaderGuide#register_prefix_descriptions')
  call leaderGuide#register_prefix_descriptions('', 'g:leaderGuide_map')
endif

autocmd FileType gitcommit  noremap <buffer> <leader> <Plug>leaderguide-buffer
" for fugitive

autocmd BufEnter __Tagbar__  noremap <buffer> <leader> <Plug>leaderguide-buffer
" for tagbar

autocmd FileType tex let g:leaderGuide_map[','].l = { 'name' : 'vimtex' }

let mapleader = ' '
let maplocalleader = ','

nnoremap <Plug>(leaderguide-global) :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <Plug>(leaderguide-global) :<c-u>LeaderGuideVisual '<Space>'<CR>
nmap <silent> <leader> <Plug>(leaderguide-global)
vmap <silent> <leader> <Plug>(leaderguide-global)

nnoremap <Plug>(leaderguide-local) :<c-u>LeaderGuide  ','<CR>
vnoremap <Plug>(leaderguide-local) :<c-u>LeaderGuideVisual  ','<CR>
nmap <localleader> <Plug>(leaderguide-local)
vmap <localleader> <Plug>(leaderguide-local)

nnoremap <Plug>(vim-edit-autocmds) :edit $VIM/vimfiles/autocmds.vim<CR>
nmap <leader>fa <Plug>(vim-edit-autocmds)

nnoremap <Plug>(vimfiler-buffer-directory) :VimFilerBufferDir<CR>
nmap <leader>fb <Plug>(vim-buffer-directory)

nnoremap <Plug>(vimfiler-current-directory) :VimFiler<CR>
nmap <leader>fc <Plug>(vim-current-directory)

nnoremap <Plug>(vim-open-vimrc) :e $VIM/vimrc<CR>
nmap <leader>fd <Plug>(vim-open-vimrc)

nnoremap <Plug>(vim-init-file) :e $VIM/vimfiles/init.vim<CR>
nmap <leader>fi <Plug>(vim-init-file)

nnoremap <Plug>(open-vimrc-keymap) :e $VIM/vimfiles/keymap.vim<CR>
nmap <leader>fk <Plug>(open-vimrc-keymap)

nnoremap <Plug>(list-file) :LeaderfFile<CR>
nmap <leader>fl <Plug>(list-file)

nnoremap <Plug>(open-vimrc-options) :edit $VIM/vimfiles/options.vim<CR>
nmap <Leader>fo <Plug>(open-vimrc-options)

nnoremap <Plug>(open-vimrc-plugins) :edit $VIM/vimfiles/plugins.vim<CR>
nmap <leader>fp <Plug>(open-vimrc-plugins)

nnoremap <Plug>(recent-file) :LeaderfMru<CR>
nmap <leader>fr <Plug>(recent-file)

nnoremap <Plug>(source-vimrc) :source %<CR>
nmap <leader>fs <Plug>(source-vimrc)

nnoremap <Plug>(file-treeview) :NERDTreeToggle<CR>
nmap <leader>ft <Plug>(file-treeview)

nnoremap <Plug>(write-file) :w<CR>
nmap <leader>fw <Plug>(write-file)

nnoremap <Plug>(list-buffer) :LeaderfBuffer<CR>
nmap <leader>bl <Plug>(list-buffer)

nnoremap <Plug>(delete-buffer) :bd<CR>
nmap <leader>bd <Plug>(delete-buffer)

nnoremap <Plug>(git-status) :Gstatus<CR>
nmap <leader>gs <Plug>(git-status)

nnoremap <Plug>(install-plugins) :PlugInstall<CR>
nmap <leader>pi <Plug>(install-plugins)

nnoremap <Plug>(upgrade-plugins) :PlugUpgrade<CR>
nmap <leader>pg <Plug>(upgrade-plugins)

nnoremap <Plug>(update-plugins) :PlugUpdate<CR>
nmap <leader>pp <Plug>(update-plugins)

nnoremap <Plug>(clean-plugins) :PlugClean<CR>
nmap <leader>pc <Plug>(clean-plugins)

nnoremap <Plug>(plugins-status) :PlugStatus<CR>
nmap <leader>ps <Plug>(plugins-status)

nnoremap <Plug>(vimshell) :VimShell<CR>
nmap <leader>ss <Plug>(vimshell)

nnoremap <Plug>(current-theme) :colorscheme<CR>
nmap <leader>sc <Plug>(current-theme)

nmap <leader>. <Plug>leaderguide-global

inoremap jk <Esc>
inoremap <C-s> <Esc>:w<cr>
nnoremap <C-s> :w<cr>
nnoremap <C-h>	<C-W>h
nnoremap <C-l>	<C-W>l
nnoremap <C-j>	<C-W>j
nnoremap <C-k>	<C-W>k


" nmap <silent> <leader>gs  :Gstatus<CR>

" nmap <silent> <leader>ol  :lopen<CR>
" nmap <silent> <leader>oo  :copen<CR>
 
" nnoremap <leader> :<C-U>LeaderGuide ' '<CR>
" nnoremap <localleader> :<C-U>LeaderGuide ','<CR>

" combine the two dictionaries into a single top-level dictionary:
" let g:topdict = {}
" let g:topdict[' '] = g:lmap
" let g:topdict[' ']['name'] = '<leader>'
" " let g:topdict[','] = g:llmap
" " let g:topdict[',']['name'] = '<localleader>'
" 
" " register it with the guide:
" call leaderGuide#register_prefix_descriptions('', 'g:topdict')
" 
" " define mappings:
" nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
" map <leader>. <Plug>leaderguide-global
" nnoremap <localleader> :<c-u>LeaderGuide  ','<CR>
" vnoremap <localleader> :<c-u>LeaderGuideVisual  ','<CR>
" map <localleader>. <Plug>leaderguide-buffer
"""""""""""""""""""""""""""""""""""""""
" 
