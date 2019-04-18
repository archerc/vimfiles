" vim: ft=vim ts=2 sw=2
let g:tex_flavor = 'latex'
let g:vimtex_view_enabled = 0
let g:vimtex_view_method = 'C:\Programs\SumatraPDF\SumatraPDF.exe'
let g:vimtex_quickfix_mode = 0
set conceallevel=1
let g:tex_conceal = 'abdmg'
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
