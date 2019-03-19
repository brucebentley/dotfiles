""
" Construct the range with given motion. Emulates `!` (exclamation) operator
" without putting '!' symbol automatically in the command mode.
"
" nnoremap <silent> ! :<C-u>set operatorfunc=bbentley#mappings#operator#construct#<Enter>g@
"
" @param {string} [type] Type of motion.
""
function! bbentley#mappings#operator#construct#(type) abort
	let [l:mstart, l:mend] = [line("'["), line("']")]

	if l:mstart == line('.')
		let [l:mstart, l:mend] = ['.', '.+' . (l:mend - l:mstart)]
	endif

	call feedkeys(':' . l:mstart . ',' . l:mend, 'in')
endfunction
