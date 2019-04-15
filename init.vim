" vim: ft=vim ts=2 sw=2 et
let init_script = expand('<sfile>')
let vimfiles = fnamemodify(init_script, ':p:h')
let scripts = glob(vimfiles . '/settings/[0-9][0-9]-*.vim', v:false, v:true)
let scripts = filter(scripts, 'filereadable(v:val)')
for file in scripts
  execute 'source ' . file
endfor
