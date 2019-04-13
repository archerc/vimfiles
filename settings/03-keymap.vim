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
      \                     'name': 'Git',
      \                   }
      \           ,  'f': {
      \                     'name': 'File',
      \                   }
      \           ,  'b': {
      \                     'name': 'buffer',
      \                   }
      \           ,  'e': {
      \                     'name': 'easymotion',
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

nmap <leader>ea <Plug>(easymotion-activate)
nmap <leader>ee <Plug>(easymotion-e)
nmap <leader>eE <Plug>(easymotion-E)
nmap <leader>ef <Plug>(easymotion-f)
nmap <leader>eF <Plug>(easymotion-F)
nmap <leader>ege <Plug>(easymotion-ge)
nmap <leader>egE <Plug>(easymotion-gE)
nmap <leader>ej <Plug>(easymotion-j)
nmap <leader>ek <Plug>(easymotion-k)
nmap <leader>et <Plug>(easymotion-t)
nmap <leader>eT <Plug>(easymotion-T)
nmap <leader>ew <Plug>(easymotion-w)
nmap <leader>eb <Plug>(easymotion-b)
nmap <leader>eW <Plug>(easymotion-W)
nmap <leader>eB <Plug>(easymotion-B)

nnoremap <Plug>(vim-edit-autocmds) :edit $VIM/vimfiles/settings/autocmds.vim<CR>
nmap <leader>fa <Plug>(vim-edit-autocmds)

nnoremap <Plug>(vimfiler-buffer-directory) :VimFilerBufferDir<CR>
nmap <leader>fb <Plug>(vimfiler-buffer-directory)

nnoremap <Plug>(vimfiler-current-directory) :VimFiler<CR>
nmap <leader>fc <Plug>(vimfiler-current-directory)

nnoremap <Plug>(vim-open-vimrc) :e $VIM/vimrc<CR>
nmap <leader>fd <Plug>(vim-open-vimrc)

nnoremap <Plug>(vim-init-file) :e $VIM/vimfiles/init.vim<CR>
nmap <leader>fi <Plug>(vim-init-file)

nnoremap <Plug>(open-vimrc-keymap) :e $VIM/vimfiles/settings/keymap.vim<CR>
nmap <leader>fk <Plug>(open-vimrc-keymap)

nnoremap <Plug>(list-file) :LeaderfFile<CR>
nmap <leader>fl <Plug>(list-file)

nnoremap <Plug>(open-vimrc-options) :edit $VIM/vimfiles/settings/options.vim<CR>
nmap <Leader>fo <Plug>(open-vimrc-options)

nnoremap <Plug>(open-vimrc-plugins) :edit $VIM/vimfiles/settings/plugins.vim<CR>
nmap <leader>fp <Plug>(open-vimrc-plugins)

nnoremap <Plug>(recent-file) :LeaderfMru<CR>
nmap <leader>fr <Plug>(recent-file)

nnoremap <Plug>(vim-reload-file) :source %<CR>
nmap <leader>fs <Plug>(vim-reload-file)

nnoremap <Plug>(file-treeview) :NERDTreeToggle<CR>
nmap <leader>ft <Plug>(file-treeview)

nnoremap <Plug>(write-file) :w<CR>
nmap <leader>fw <Plug>(write-file)

nnoremap <Plug>(list-buffer) :LeaderfBuffer<CR>
nmap <leader>bl <Plug>(list-buffer)

nnoremap <Plug>(delete-buffer) :bd<CR>
nmap <leader>bd <Plug>(delete-buffer)

nnoremap <Plug>(git-commit-amend) :Gcommit --amend<CR>
nmap <leader>ga <Plug>(git-commit-amend)

nnoremap <Plug>(git-commit) :Gcommit<CR>
nmap <leader>gc <Plug>(git-commit)

nnoremap <Plug>(git-pull) :Gpull<CR>
nmap <leader>gp <Plug>(git-pull)

nnoremap <Plug>(git-push) :Gpush<CR>
nmap <leader>gq <Plug>(git-push)

nnoremap <Plug>(git-status) :Gstatus<CR>
nmap <leader>gs <Plug>(git-status)

nnoremap <Plug>(git-write) :Gwrite<CR>
nmap <leader>gw <Plug>(git-write)

nnoremap <Plug>(open-locations) :lopen<CR>
nmap <silent> <leader>ol  <Plug>(open-locations)

nnoremap <Plug>(open-quickfix) :copen<CR>
nmap <silent> <leader>oo  <Plug>(open-quickfix)

nnoremap <Plug>(plug-install) :PlugInstall<CR>
nmap <leader>pi <Plug>(plug-install)

nnoremap <Plug>(plug-upgrade) :PlugUpgrade<CR>
nmap <leader>pg <Plug>(plug-upgrade)

nnoremap <Plug>(plug-update) :PlugUpdate<CR>
nmap <leader>pp <Plug>(plug-update)

nnoremap <Plug>(plug-clean) :PlugClean<CR>
nmap <leader>pc <Plug>(plug-clean)

nnoremap <Plug>(plug-status) :PlugStatus<CR>
nmap <leader>ps <Plug>(plug-status)

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
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

 
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
