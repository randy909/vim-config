" autocmds go here

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Make first click in window *not* reposition cursor (might break lastpos
" plugin) http://www.mail-archive.com/vim_use@googlegroups.com/msg17539.html
autocmd FocusGained * call getchar(0)

autocmd BufNewFile,BufRead *.hjs set filetype=html

