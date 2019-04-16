let g:pandoc#command#autoexec_command = "exe 'Pandoc! pdf --pdf-engine=xelatex --output=\\\"'.expand('%:t:r').'.pdf\\\"'"
" let g:pandoc#command#autoexec_command = "Pandoc! pdf --pdf-engine=xelatex"
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#latex_engine = "xelatex"
