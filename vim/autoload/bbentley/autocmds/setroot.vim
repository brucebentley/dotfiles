""
" Asynchronously set current working directory to git root.
"
" TODO: Support vim's job_start() API.
"
" autocmd VimEnter,BufEnter * call bbentley#autocmds#setroot#()
""
function! bbentley#autocmds#setroot#() abort
	if !executable('git') || !has('nvim')
		return v:false
	endif

	let l:process = {}

	function! l:process.on_stdout(jobid, data, event) abort
		let l:root = a:data[0]

		if l:root !=# $HOME
			execute 'cd' l:root
		endif
	endfunction

	call jobstart('git rev-parse --show-toplevel', l:process)
endfunction
