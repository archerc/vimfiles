" lib.vim: Vim library manager
" ============================
" Copyright (c) 2017 Junegunn Choi
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if exists('g:loaded_lib')
  finish
endif
let g:loaded_lib = 1

let s:cpo_save = &cpo
set cpo&vim

let s:dll = {}
let s:libcurl = glob($VIM . '/vim81/libcurl-4.dll')
if filereadable(s:libcurl)
	let s:dll['libcurl'] = s:libcurl
endif
let s:everything = glob(fnamemodify(expand('<sfile>'), ':p:h:h') . '/lib/everything.dll')
if filereadable(s:everything)
	let s:dll['everything'] = s:everything
endif

function! lib#call(name, argument) abort
	if has_key(s:dll, name)
		let dll = s:dll[name]
		return libcallnr(dll, argument)
	endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
