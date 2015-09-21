" This file contains code common to both minrc and vimrc

" Fix the runtime path so vim sees the directory we are in as the .vim directory.
" This is useful for making both windows gvim and cygwin vim happy with a single config.
" See: http://stackoverflow.com/questions/3377298/how-can-i-override-vim-and-vimrc-paths-but-no-others-in-vim

" set default 'runtimepath' (without ~/.vim folders)
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" what is the name of the directory containing this file?
let s:portable = expand('<sfile>:p:h')

" add the directory to 'runtimepath'
let &runtimepath = printf('%s,%s,%s/after', s:portable, &runtimepath, s:portable)


" source the files living next to this one
source <sfile>:p:h/settings.vim
source <sfile>:p:h/mappings.vim
source <sfile>:p:h/funrc.vim
source <sfile>:p:h/autocmd.vim
