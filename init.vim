" vim: ft=vim ts=2 sw=2 et
let scripts = ['options.vim', 'plugins.vim', 'keymap.vim', 'autocmds.vim']
let s:sep = '\'
for file in scripts
	let filepath = $VIM . s:sep . 'vimfiles' . s:sep . file
	if filereadable(filepath)
		execute 'source ' . filepath
	endif
endfor
