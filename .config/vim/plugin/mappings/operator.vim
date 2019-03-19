" Construct range operator.
nnoremap <silent> ! :<C-u>set operatorfunc=bbentley#mappings#operator#construct#<Enter>g@

" Send given motion to appropriate REPL operator.
nnoremap <silent> gx :<C-u>let b:executeoperatorview = winsaveview() <Bar> set operatorfunc=bbentley#mappings#operator#execute#<Enter>g@
xnoremap <silent> gx :<C-u>call bbentley#mappings#operator#execute#(visualmode())<Enter>
nnoremap <silent> gxl :<C-u>let b:executeoperatorview = winsaveview() <Bar> set operatorfunc=bbentley#mappings#operator#execute#<Bar> execute 'normal!' v:count 'g@_'<Enter>

" Comment and uncomment operator.
nnoremap <silent> gc :<C-u>set operatorfunc=bbentley#mappings#operator#comment#<Enter>g@
xnoremap <silent> gc :<C-u>call bbentley#mappings#operator#comment#(visualmode())<Enter>
