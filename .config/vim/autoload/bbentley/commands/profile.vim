""
" Start profiling until it's invoked with ! modifier once again.
"
" command! -bang Profile call bbentley#commands#profile#(<bang>v:false)
"
" @param {boolean} [bang=v:false] Stop profiling and quit without triggering events.
""
function! bbentley#commands#profile#(bang) abort
	if !a:bang
		profile start ~/.vim/cache/log/profile.log
		profile func *
		profile file *
	else
		profile pause
		noautocmd qall
	endif
endfunction
