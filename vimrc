" To use create a (.|_)gvimrc file in $HOME that contains a line like this:
" (you could do something similar with symlinks but it doesn't work well on
" windows with cygwin)
"  source $HOME/.vim/vimrc
" or for windows:
"  source $HOME/vimfiles/vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" My own halfway point between behave mswin and xterm
" TODO: do I want to source mswin.vim here? probably don't want to kill <C-x>
set mousemodel=popup " right click should popup not extend
set keymodel=startsel,stopsel " allow shift-<end> style selection
set selection=inclusive " include last char on line when mouse selecting

" make visual block work the way it should (go past end of line).
" might also want to experiment with "onemore" in addition to "block" -
" it lets you put the cursor on the eol character rather than one before it.
set virtualedit=block

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
set cursorline		" show a bar over the line with the cursor
set incsearch		" do incremental searching
set hlsearch		" highlight seach matches

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

" Folding
set foldenable
set foldcolumn=2 " show +/- column like ide
set foldmethod=syntax
let perl_fold=1 "turn on folding in perl

set enc=utf-8
" Use the same symbols as TextMate for tabstops and EOLs
" For consolas the available characters can be found here:
" http://www.fileformat.info/info/unicode/font/consolas/grid.htm
set listchars=tab:›\ ,eol:¬
set list

" make j/k go up/down by screen line instead of file line
nnoremap j gj
nnoremap k gk

" fix mintty home/end keys for delimitMate
" TODO: put a map here for shift-tab functionality (skip closing }])"etc.)
imap <Esc>OH <Plug>delimitMateHome
imap <Esc>OF <Plug>delimitMateEnd

" map <C-/> to toggle comment and leave originals intact
" TODO: this mapping doesn't work on gvim
" there is a different way to map strange characters: <Char-234> where 324 is
" the ascii number for that code. That *might* fix this. See the Yankring help
" and search for <Char- to find the part that explains this.
nmap  <Plug>NERDCommenterToggle
vmap  <Plug>NERDCommenterToggle
nmap ,c<space> <Plug>NERDCommenterToggle
vmap ,c<space> <Plug>NERDCommenterToggle

" map <F3> to show/close YankRing buffer
" TODO: it would be cool if when you F3 from insert mode it would go back to 
" insert mode after you paste
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
