set tabstop=4
set softtabstop=4
set shiftwidth=4

" Eclim prefs and maps
let g:EclimJavaSearchSingleResult='edit'
inoremap <C-space> <C-x><C-u>
nnoremap <leader>q :JavaCorrect<cr>
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <c-cr> :JavaSearchContext<cr>
