" vim: ft=vim ts=2 sw=2
let g:tex_flavor = 'pdflatex'
set conceallevel=1
let g:tex_conceal = 'abdmg'
let g:vimtex_quickfix_mode = 1

let g:vimtex_compiler_enabled = 1

let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'jobs',
        \ 'background' : 1,
        \ 'build_dir' : '.',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
				\   '-pdf',
        \   '-interaction=nonstopmode',
        \ ],
        \}

let g:vimtex_compiler_latexmk_engines = {
			\ '_'                : '-pdf',
			\ 'pdflatex'         : '-pdf',
			\ 'dvipdfex'         : '-pdfdvi',
			\ 'lualatex'         : '-lualatex',
			\ 'xelatex'          : '-xelatex',
			\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
			\ 'context (luatex)' : '-pdf -pdflatex=context',
			\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
			\}

let g:vimtex_view_enabled = 1
"let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
			\ = '-reuse-instance -forward-search @tex @line @pdf'
			\ . ' -inverse-search "gvim --servername ' . v:servername
			\ . ' --remote-send \"^<C-\^>^<C-n^>'
			\ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
			\ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
			\ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
			\ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
if !exists('g:leaderGuide_map')
	let g:leaderGuide_map = {};
endif
if !has_key(g:leaderGuide_map, ',')
	let g:leaderGuide_map[','] = {'name': 'Local LeaderGudie map'}
endif
