""
" Set search register to current visual selection.
"
" xnoremap * :<C-u>call bbentley#mappings#visual#setsearch#('/')<Enter>/<C-r>=@/<Enter><Enter>
" xnoremap # :<C-u>call bbentley#mappings#visual#setsearch#('?')<Enter>?<C-r>=@/<Enter><Enter>
"
" @param {string} searchtype Direction for search command, either '/' or '?'.
""
function! bbentley#mappings#visual#setsearch#(searchtype) abort
	let l:temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, a:searchtype . '\'), '\n', '\\n', 'g')
	let @s = l:temp
endfunction
