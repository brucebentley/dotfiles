" Local command-line window settings.
augroup commandlinewindow
    autocmd!
    autocmd CmdwinEnter * setlocal signcolumn=no nonumber norelativenumber
augroup end

" Start insert mode and disable line numbers in terminal buffer.
augroup terminalsettings
    autocmd!
    if has('nvim')
        autocmd TermOpen * setlocal nonumber norelativenumber
        autocmd TermOpen * startinsert
    endif
augroup end

" Toggle relative numbers in Insert/Normal mode.
augroup togglenumbers
    autocmd!
    autocmd InsertEnter,BufLeave,WinLeave,FocusLost * call bbentley#autocmds#togglenumbers#('setlocal norelativenumber')
    autocmd InsertLeave,BufEnter,WinEnter,FocusGained * call bbentley#autocmds#togglenumbers#('setlocal relativenumber')
augroup end

" Save the current buffer after any changes.
augroup savebuffer
    autocmd!
    autocmd InsertLeave,TextChanged * nested call bbentley#autocmds#savebuffer#()
    autocmd FocusGained,BufEnter,CursorHold * silent! checktime
augroup end

" Set current working directory project root.
augroup setroot
    autocmd!
    autocmd VimEnter,BufEnter * call bbentley#autocmds#setroot#()
augroup end

" Jump to last known position and center buffer around cursor.
augroup jumplast
    autocmd!
    autocmd BufWinEnter ?* call bbentley#autocmds#jumplast#()
augroup end

" Remove trailing whitespace characters.
augroup trimtrailing
    autocmd!
    autocmd BufWritePre * call bbentley#autocmds#trimtrailing#()
augroup end

" Open file explorer if argument list contains at least one directory.
augroup openexplorer
    autocmd!
    autocmd VimEnter * call bbentley#autocmds#openexplorer#()
augroup end

" Create directory path if it's not exist.
augroup makemissing
    autocmd!
    autocmd BufWritePre * call bbentley#autocmds#makemissing#(expand('<afile>:p:h'), v:cmdbang)
augroup end
