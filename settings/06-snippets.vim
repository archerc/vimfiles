try
	py3 import vim
	let g:UltiSnipsUsePythonVersion = 3
	let g:_uspy = ':python3'
catch
	try
		py import vim
		let g:UltiSnipsUsePythonVersion = 2
	catch
		echo 'python can not enabled'
	endtry
endtry

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

