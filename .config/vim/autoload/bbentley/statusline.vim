scriptencoding UTF-8

function! bbentley#statusline#linter() abort
    if !exists('g:loaded_ale')
        return ''
    endif

    let l:counts = ale#statusline#Count(bufnr(''))

    let l:allerrors = l:counts.error + l:counts.style_error
    let l:allwarnings = l:counts.total - l:allerrors

    return printf(' %d  %d', l:allerrors, l:allwarnings)
endfunction

function! bbentley#statusline#fileprefix() abort
    let l:basename = expand('%:h')

    if l:basename ==# '' || l:basename ==# '.'
        return ''
    else
        return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
    endif
endfunction

function! bbentley#statusline#filetypesymbol() abort
    if !exists('*WebDevIconsGetFileTypeSymbol')
        return ''
    endif

    return WebDevIconsGetFileTypeSymbol()
endfunction

function! bbentley#statusline#hlsearch() abort
    if !&hlsearch
        return ''
    endif

    return '' . ' '
endfunction

function! bbentley#statusline#spell() abort
    if !&spell
        return ''
    endif

    return '' . ' '
endfunction

function! bbentley#statusline#git() abort
    if !exists('g:loaded_gina')
        return ''
    endif

    return gina#component#repo#branch() . ' '
endfunction

function! bbentley#statusline#markdownpreview() abort
    if !exists('b:markdownpreview')
        return ''
    endif

    return '' . ' '
endfunction

function! bbentley#statusline#nerdtree() abort
    if !exists('b:NERDTree')
        return v:false
    endif

    return substitute(b:NERDTree.root.path.str() . '/', '\C^' . $HOME, '~', '')
endfunction
