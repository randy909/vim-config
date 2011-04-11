" To use create a (.|_)gvimrc file in $HOME that contains a line like this:
" (you could do something similar with symlinks but it doesn't work well on
" windows with cygwin)
"  source $HOME/.vim/vimrc
" or for windows:
"  source $HOME/vimfiles/vimrc

" Tips:
" Use 'ga' in normal mode to get the ascii value of the char under the cursor.
" TODO: make a 'tips' file for stuff like this
" Use '\v' while searching to enable 'very magic' regexes (like Perl).
" Use :noh to remove current search highlights.

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" source the files living next to this one
source <sfile>:p:h/mswin.vim
source <sfile>:p:h/funrc.vim

" make visual block work the way it should (go past end of line).
" might also want to experiment with "onemore" in addition to "block" -
" it lets you put the cursor on the eol character rather than one before it.
set virtualedit=block

set cursorline         " show a bar over the line with the cursor
set encoding=utf-8     " utf-8 is great
set display=lastline   " display partial lines at end of screen
set hidden             " allow unwritten buffers to hide
set history=50         " keep 50 lines of command line history
set lazyredraw         " don't update screen wile executing macros
set number             " show line numbers
set ruler              " show the cursor position all the time
set scrolloff=3        " keep 3 lines visible at top/bottom
set showcmd            " display incomplete commands
set tags=tags;/        " look for tags file all the way down to root
set ttimeoutlen=10     " make vim exit search/visual with <exc> quickly"
set ttyfast            " draw smoother if terminal is fast
set visualbell t_vb=   " turn off bells in all forms

" make cursor into a line that blinks a little slower
set guicursor+=n-v-c:ver25-Cursor/lCursor
set guicursor+=a:blinkwait500-blinkoff500-blinkon500

" wildmenu/mode does cool autocompletion on the command line
set wildmenu
set wildmode=list:longest,full

" search settings
set incsearch       " do incremental searching
set hlsearch        " highlight seach matches
set ignorecase      " ignore case if all lowercase
set smartcase       " match uppercase if any characters are upper
set gdefault        " default s///g on substitutions

" tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Put backup, undo, and swap files somewhere other that pwd
" ~ seems to work on windows as well
set backup   " keep a backup file
set undofile " keep a undo file
set directory=~/tmp//,~//,. " trailing slash prevents name collisions
set backupdir=~/tmp,~/,.
set undodir=~/tmp,~/,.

" Folding
set nofoldenable
"set foldcolumn=2 " show +/- column like ide
"set foldlevel=99 " start with all folds open
"set foldmethod=syntax
"let perl_fold=1 "turn on folding in perl

" Use the same symbols as TextMate for tabstops and EOLs
" For consolas the available characters can be found here:
" http://www.fileformat.info/info/unicode/font/consolas/grid.htm
set listchars=tab:›\ ,eol:¬
set list

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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
  " TODO: make this work in terminal
  autocmd FocusGained * call getchar(0)

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

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

" make j/k go up/down by screen line instead of file line
nnoremap j gj
nnoremap k gk

" use ; for : too so I don't have to hit <shift>
nnoremap ; :

" fix mintty home/end keys for delimitMate
" TODO: put a map here for shift-tab functionality (skip closing }])"etc.)
" because shift-tab is hogged by snipmate.
if !has("gui_running")
  exec "set <Home>=OH"
  exec "set <End>=OF"
endif

" make delimitmate act "smart" like eclipse
let g:delimitMate_smart_matchpairs = '^\%(\w\|\!\|£\|\$\|_\|["'']\s*\S\)'

" make delimitmate put extra <cr> after open bracket
let delimitMate_expand_cr = 1

" enable all modes for FuzzyFinder
let g:fuf_modesDisable = []

" CommandT prefs
let g:CommandTMatchWindowAtTop=1
let g:CommandTMaxHeight=30

" look for ack in home/bin
" TODO: figure out a good system for having ack installed somwhere this plugin
" can find it every time. maybe install it in the vimfiles directory
" or figure out how to use $HOME/bin from the 'let blah' variables
if has("gui_running")
  let g:ackprg="perl C:\\cygwin\\home\\p054441\\bin\\ack -H --nocolor --nogroup --column"
endif

" map <C-/> and <A-/> to toggle comment and leave originals intact
" <A-/> is a workaround for gvim not allowing <C-/> mapping
" TODO: submit a patch to gvim to fix this.
if has("gui_running")
  nmap <A-/> <Plug>NERDCommenterToggle
  vmap <A-/> <Plug>NERDCommenterToggle
else
  nmap  <Plug>NERDCommenterToggle
  vmap  <Plug>NERDCommenterToggle
endif

nmap ,c<space> <Plug>NERDCommenterToggle
vmap ,c<space> <Plug>NERDCommenterToggle

" map <F2> to toggle NERDTree
nnoremap <silent> <F2> :NERDTreeToggle<cr>
inoremap <silent> <F2> <ESC>:NERDTreeToggle<cr>

" map <F3> to show/close YankRing buffer
" TODO: it would be cool if when you F3 from insert mode it would go back to
" insert mode after you paste
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" Give Textmate's indentation commands a whirl
if has("gui_running")
  nmap <A-[> <<
  nmap <A-]> >>
  vmap <A-[> <gv
  vmap <A-]> >gv
endif

" Indents (=) the entire file.
nmap ,= :call Preserve("normal gg=G")<CR>

" Deletes trailing whitespace for the entire file.
nmap ,$ :call Preserve("%s/\\s\\+$//e")<CR>

" Highlight trailing whitespace except current line.
" I chose a dark grey from molokai because I don't need
" too much highlighting - I'm already printing the eol character.
highlight ExtraWhitespace ctermbg=16 guibg=#232526
match ExtraWhitespace /\s\+\%#\@<!$/


" TODO: install the syntastic plugin for realtime syntax checking
" TODO: figure out how to run unit tests without exiting vim with quickfix etc.

