" To use this file create a file in $home called .vimrc (unix) or _vimrc (win)
" and put the following line in it:
"  source $HOME/.vim/vimrc
" or for windows:
"  source $HOME/vimfiles/vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" TODO: understand this
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch            " highlight seach matches

" TODO: understand this
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" TODO: understand this
" Don't use Ex mode, use Q for formatting
map Q gq

" TODO: understand this
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype off  "prepare to load pathogen
  call pathogen#runtime_append_all_bundles() "load pathogen
  filetype plugin indent on

" TODO: understand this
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

" TODO: understand this
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

" TODO: do I like this? i guess...
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

" TODO: understand this why in the 'else' of if autocmd
  set autoindent		" always set autoindenting on

endif " has("autocmd")

" TODO: learn how to get out of this safely (<C-W>, left arrow moves to the
" left pane then you can :q out of that one and everything is back to normal)
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

syntax on
"let g:molokai_original=1
colorscheme molokai
"colorscheme ir_black

"turn on folding
set foldenable
set foldmethod=syntax
let perl_fold=1 "turn on folding in perl


