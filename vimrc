" 系统默认配置文件
if !exists('vimrc')
    let vimrc = $VIM . '/vimfiles/init.vim'
endif
if filereadable(vimrc)
    execute 'source ' . vimrc
endif
if !exists('gvimrc')
    let gvimrc = $VIM . '/vimfiles/gui.vim'
endif
if filereadable(gvimrc)
    execute 'source ' . gvimrc
endif
