""
" Open file explorer if argument list contains at least one directory.
"
" autocmd VimEnter * call bbentley#autocmds#openexplorer#()
""
function! bbentley#autocmds#openexplorer#() abort
	let l:directory = expand('<amatch>')

	if isdirectory(l:directory)
		execute printf('cd %s', fnameescape(l:directory))

		packadd nerdtree
		NERDTree
		only
	endif
endfunction
