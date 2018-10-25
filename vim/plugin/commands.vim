" Run any command under toggle terminal.
command -nargs=* -complete=shellcmd T call bbentley#terminal#execute(<q-args>)

" Open documentations for given query.
command -nargs=* Docs call bbentley#commands#docs#("<args>")

" Start profiling until it's invoked with ! modifier once again.
command -bang Profile call bbentley#commands#profile#(<bang>v:false)

" Display the contents of all registers in vertical split like `:registers`.
command Registers call bbentley#commands#registers#()

" Search text in git repository or current working directory.
command -nargs=1 -bang Search call bbentley#commands#search#(<bang>v:false, <args>)
