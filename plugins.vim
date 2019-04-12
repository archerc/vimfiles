let bundle_root = $VIM . '/vimfiles/bundle'
let plugins = [ 
			\   'vim-startify'
			\ , 'dein.vim'
			\ , 'dein-ui.vim'
			\ , 'dein-command.vim'
			\ , 'context_filetype.vim'
			\ , 'AutoComplPop'
			\ , 'vim-matlab'
			\ , 'unite-outline'
			\ , 'unite-git-log'
			\ , 'ruler.vim'
			\ , 'python-mode'
			\ , 'peaksea'
			\ , 'nerdcommenter'
			\ , 'nginx.vim'
			\ , 'neomru.vim'
			\ , 'vim-easymotion'
			\ , 'vim-instant-markdown'
			\ , 'limelight.vim'
			\ , 'echodoc.vim'
			\ ]
""""""""""""""""""""""""""""""""""""""
"""  vim-plug
call plug#begin(bundle_root)

let s:sep = has('win32') ? '\' : '/'
for p in plugins
	let path = expand('<sfile>:p:h') . s:sep  . 'bundle' . s:sep . p 
	call plug#(path)
endfor

" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'archerc/vim-leader-guide'
Plug 'archerc/vimim'
Plug 'archerc/gvimfullscreen'
Plug 'chemzqm/denite-git'
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
Plug 'morhetz/gruvbox'
" �ӳٰ�����أ�ʹ�õ������ʱ���ټ��ػ��ߴ򿪶�Ӧ�ļ����Ͳż���
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
" �Զ��� quickfix window ���߶�Ϊ 6
let g:asyncrun_open = 0

" �������ʱ����������
let g:asyncrun_bell = 1

" ���� F10 ��/�ر� Quickfix ����
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" ���� F9 Ϊ���뵥�ļ�:
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" ͬʱ�� F5 ���У�
" nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" ���尴 F7 ����������Ŀ��
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" ������ F8 ���е�ǰ��Ŀ��
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

" �� F6 ִ�в��ԣ�
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" F4 Ϊ���� Makefile �ļ���������� cmake ���Ժ��ԣ�
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
let g:UltiSnipsSnippetDirectories=[$VIM.'/vimfiles/UltiSnips']
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
""" vimproc
let g:vimproc_dll_url = 'https://github.com/Shougo/vimproc.vim/releases/download/ver.9.3/vimproc_win64.dll'
""""""""""""""""""""""""""""""""""""""
