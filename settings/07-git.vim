
" Vimagit:
let g:magit_default_fold_level = 0
nnoremap <Plug>(git-magit) :Magit<CR>
nmap <leader>gg <Plug>(git-magit)

nnoremap <Plug>(git-magit-only) :MagitOnly<CR>
nmap <leader>go <Plug>(git-magit-only)


" Fugitive: 
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

