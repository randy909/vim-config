" To use this instead of vimrc do:
"  alias vim='vim -u $HOME/.vim/minrc.vim'

" source the files living next to this one
source <sfile>:p:h/settings.vim
source <sfile>:p:h/mappings.vim
source <sfile>:p:h/funrc.vim
source <sfile>:p:h/autocmd.vim

" TODO: figure out how to only load some plugins like surround and commentary.
" Might have to switch to vundle...

colorscheme molokai

syntax off
