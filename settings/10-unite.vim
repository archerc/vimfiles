" vim:set noet sts=0 sw=8 ts=8 tw=78:

let g:unite_enable_start_insert = 1
nnoremap <Plug>(unite-file) :Unite file/async file_rec/async file_rec/git<CR>
nmap <leader>uf <Plug>(unite-file)
" interactive file/async                -- asynchronous candidates from file list
" interactive file_rec/async            -- asynchronous candidates from directory by recursive
" interactive file_rec/neovim           -- neovim asynchronous candidates from directory by recursive
" interactive file_point                -- file candidate from cursor point
" interactive file_list                 -- candidates from filelist
" interactive file                      -- candidates from file list
" interactive file_rec/git              -- git candidates from directory by recursive
" interactive file_rec                  -- candidates from directory by recursive
" interactive file/new                  -- file candidates from input

nnoremap <Plug>(unite-snippets) :Unite -start-insert ultisnips<CR>
nmap <leader>ua <Plug>(unite-snippets)

nnoremap <Plug>(unite-buffer) :Unite buffer buffer_tab<CR>
nmap <leader>ub <Plug>(unite-buffer)

nnoremap <Plug>(unite-gitlog) :Unite -start-insert gitlog<CR>
nmap <leader>ug <Plug>(unite-gitlog)

nnoremap <Plug>(unite-lines) :Unite -start-insert line<CR>
nmap <leader>ul <Plug>(unite-lines)

nnoremap <Plug>(unite-sources) :Unite -start-insert<CR>
nmap <leader>us <Plug>(unite-sources)

nnoremap <Plug>(unite-shellcmd) :Unite -start-insert output/shellcmd<CR>
nmap <leader>u! <Plug>(unite-shellcmd)
