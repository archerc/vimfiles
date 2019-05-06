" vim: ft=vim fenc=utf-8 ts=2 sw=2
let bundle_root = glob($VIM . '/vimfiles/bundle')
let plugins = [ 
			\   'mhinz/vim-startify'
			\ , 'jceb/vim-orgmode'
			\ , 'geratheon/vim-translate'
			\ , 'chemzqm/vim-easygit'
			\ , 'eugeii/consolas-powerline-vim'
			\ , 'bling/vim-bufferline'
			\ , 'vim-airline/vim-airline-themes'
			\ , 'jlanzarotta/bufexplorer'
			\ , 'Valloric/YouCompleteMe'
			\ , 'lervag/vimtex'
			\ , 'Shougo/dein.vim'
			\ , 'wsdjeg/dein-ui.vim'
			\ , 'haya14busa/dein-command.vim'
			\ , 'Shougo/context_filetype.vim'
			\ , 'vim-scripts/AutoComplPop'
			\ , 'daeyun/vim-matlab'
			\ , 'djoshea/vim-matlab-fold'
			\ , 'Shougo/unite-outline'
			\ , 'chemzqm/unite-git-log'
			\ , 'vim-scripts/ruler.vim'
			\ , 'vim-scripts/vim-line-numbers'
			\ , 'python-mode/python-mode'
			\ , 'vim-scripts/peaksea'
			\ , 'scrooloose/nerdcommenter'
			\ , 'vim-scripts/nginx.vim'
			\ , 'easymotion/vim-easymotion'
			\ , 'suan/vim-instant-markdown'
			\ , 'junegunn/limelight.vim'
			\ , 'Shougo/echodoc.vim'
			\ ]
"			\ , 'Shougo/neomru.vim'
""""""""""""""""""""""""""""""""""""""
"""  vim-plug
call plug#begin(bundle_root)

" let s:sep = has('win32') ? '\' : '/'
for path in plugins
	call plug#(path)
endfor

" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'archerc/vim-leader-guide'
Plug 'archerc/vimim'
Plug 'archerc/gvimfullscreen'
Plug 'chemzqm/denite-git'
Plug 'diepm/vim-rest-console'
Plug 'https://github.com/bounceme/remote-viewer' " Browse ssh:// and other remote paths
" Plug 'https://github.com/kristijanhusak/vim-dirvish-git' " Show git status of each file
Plug 'https://github.com/fsharpasharp/vim-dirvinist'  " List files defined by projections
Plug 'honza/vim-snippets'
Plug 'jreybert/vimagit'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'liuchengxu/vim-which-key'
Plug 'mklabs/vim-json'
Plug 'morhetz/gruvbox'
" 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sgur/vim-textobj-parameter'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/quickmenu.vim'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-fugitive', { 'on': 'Gstatus' }
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'w0rp/ale'
Plug 'yianwillis/vimcdoc'

Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/vimproc'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimshell'
Plug 'Shougo/unite.vim'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/LeaderF'
Plug 'Yggdroot/LeaderF-marks'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" 
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" 
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" 
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" 
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" 
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" 
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" 
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" 
" Initialize plugin system
call plug#end()
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" AsyncRun
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 0

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" 定义 F9 为编译单文件:
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 同时按 F5 运行：
" nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 定义按 F7 编译整个项目：
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" 配置用 F8 运行当前项目：
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

" 按 F6 执行测试：
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" F4 为更新 Makefile 文件，如果不用 cmake 可以忽略：
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" NERDTree
let NERDTreeHijackNetrw=1
""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""
""" Vimagit
let g:magit_show_magit_mapping='m'
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" Pandoc
let g:pandoc#folding#level=1
let g:asyncrun_encs = 'gbk' " - set shell encoding if it's different from '&encoding',
" nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) pandoc % -o "$(VIM_ROOT)/html/$(VIM_FILENOEXT).html"<cr>
" nnoremap <silent> <F5> :AsyncRun -cwd=<root> :make <CR>
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" LeaderF
let g:Lf_ShortcutF = '<C-P>'
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" Unite
let g:unite_kind_file_delete_directory_command="rmdir"  
let g:unite_kind_file_delete_file_command='rm'
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" UltiSnip
"let g:UltiSnipsSnippetDirectories=[$VIM.'/vimfiles/UltiSnips']
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" vimproc
let g:vimproc_dll_url = 'https://github.com/Shougo/vimproc.vim/releases/download/ver.9.3/vimproc_win64.dll'
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" context_filetype
if !exists('g:context_filetype#filetypes')
	let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.perl6 =
			\ [{'filetype' : 'pir', 'start' : 'Q:PIR\s*{', 'end' : '}'}]
let g:context_filetype#filetypes.vim =
			\ [{'filetype' : 'python',
			\   'start' : '^\s*python <<\s*\(\h\w*\)', 'end' : '^\1'}]
let g:context_filetype#filetypes.pandoc =
			\ [{'filetype' : 'tex',
			\ 	'start' : '^\\begin{align}', 'end' : '\\end{align}'}]
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" Startify
let g:startify_lists = [
			\ { 'type': 'files',     'header': ['   MRU']            },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" translate
let g:translate_src = "en"
let g:translate_dst = "cn"
""""""""""""""""""""""""""""""""""""""
