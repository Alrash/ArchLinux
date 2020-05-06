function! myspacevim#before() abort
    " 切换paste模式 
    set pastetoggle=<F12>

    " 仅对latex与markdown文件自动换行
    au BufNewFile,BufFilePre,BufRead *.md,*.tex set wrap

    " normal模型下，防止自动换行后的跳转问题
    nnoremap +<Up> k
    nnoremap +<Down> j
    nnoremap +<Left> h
    nnoremap +<Right> l
endf

