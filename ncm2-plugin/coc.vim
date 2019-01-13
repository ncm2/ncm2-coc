
func! g:CocNcm2Init()
    " register coc as ncm2 source
    call ncm2#register_source({'name' : 'coc',
            \ 'priority': 7,
            \ 'mark': '', 
            \ 'word_pattern': '\S+',
            \ 'complete_length': 1,
            \ 'on_complete': 'CocNcm2Complete',
            \ 'sorter': 'none',
            \ 'matcher': 'substrfuzzy',
            \ 'filter': 'none'
            \ })

    inoremap <silent> <Plug>_ <c-r>=CocNcm2Update()<cr>
endfunc

let s:coc_last_ctx = {}
let g:coc#_context = {}

func! g:CocNcm2Update()
    if empty(s:coc_last_ctx)
        return ''
    endif
    let candidates = get(g:coc#_context, 'candidates', [])
    for m in candidates
        let m.coc_user_data = m.user_data
    endfor
    call ncm2#complete(s:coc_last_ctx, get(g:coc#_context, 'start', 0) + 1, candidates)
    return ''
endfunc

func! g:CocNcm2Complete(ctx)
    let s:coc_last_ctx = a:ctx
    let candidates = get(g:coc#_context, 'candidates', [])
    for m in candidates
        let m.coc_user_data = m.user_data
    endfor
    " FIXME ncm2 use character addressing instead of byte addressing for start
    call ncm2#complete(a:ctx, get(g:coc#_context, 'start', 0) + 1, candidates)
endfunc

" this is useless for ncm2
func! coc#_reload()
endfunc

function! coc#_hide() abort
    let g:coc#_context = {}
    if empty(s:coc_last_ctx)
        return
    endif
    call ncm2#complete(s:coc_last_ctx, 1, [])
endfunction

call g:CocNcm2Init()
