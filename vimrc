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

set complete-=i        " don't search included file with <c-n> or <c-p>
set cursorline         " show a bar over the line with the cursor
set encoding=utf-8     " utf-8 is great
set display=lastline   " display partial lines at end of screen
set hidden             " allow unwritten buffers to hide
set history=500        " keep 500 lines of command line history
set lazyredraw         " don't update screen wile executing macros
set number             " show line numbers
set ruler              " show the cursor position all the time
set scrolloff=3        " keep 3 lines visible at top/bottom
set showcmd            " display incomplete commands
set tags=tags;/        " look for tags file all the way down to root
"set ttimeout notimeout " don't timeout :mappings (i.e. <leader>)
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
set shiftround      " make indent command "round" to multiple of 'shiftwidth'
set expandtab

" Put backup, undo, and swap files somewhere other that pwd
" ~ seems to work on windows as well
set backup   " keep a backup file
set directory=~/tmp//,~//,. " trailing slash prevents name collisions
set backupdir=~/tmp,~/,.
if version >= 703
  set undofile " keep a undo file
  set undodir=~/tmp,~/,.
endif

" Folding
set nofoldenable
"set foldcolumn=2 " show +/- column like ide
"set foldlevel=99 " start with all folds open
"set foldmethod=syntax
"let perl_fold=1 "turn on folding in perl

" Use the same symbols as TextMate for tabstops and EOLs
" You can see the symbols with :h digraph-table
"set listchars=tab:›\ ,eol:¬,trail:·
set listchars=tab:›\ ,trail:·
set list

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" TODO: understand this
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

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


" syntax highlighting stuff
set t_Co=256 " enable more colors for vim, gvim ignores it
syntax on
call togglebg#map("<F8>")
"let g:solarized_contrast="high"
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" TODO: disabling this for now since I'm printing middle dots instead.
" I think it should be moved to the molokai syntax file since sometimes this
" just flakes out and stops working, especially when i've got multiple buffers
" open.
"
" Highlight trailing whitespace except current line.
" I chose a dark grey from molokai because I don't need
" too much highlighting - I'm already printing the eol character.
"highlight ExtraWhitespace ctermbg=16 guibg=#232526
"match ExtraWhitespace /\s\+\%#\@<!$/

let mapleader = ","

" make alt-j/k go up/down by screen line instead of file line
nnoremap <A-j> gj
nnoremap <A-k> gk

" use ; for : too so I don't have to hit <shift>
nnoremap ; :
vnoremap ; :
nnoremap q; q:

" replace ; and , with <space> and <shift-space>
nnoremap <space> ;
nnoremap <S-space> ,

" Create newlines easily in normal mode
" The second one splits the line where the cursor is
" nnoremap <CR> o<ESC>    this screws up quickfix jumping to files
nnoremap <S-CR> o<ESC>
nnoremap <C-CR> i<CR><ESC>k$

" Map <C-hjkl> to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Give Textmate's indentation commands a whirl
if has("gui_running")
  nmap <A-[> <<
  nmap <A-]> >>
  vmap <A-[> <gv
  vmap <A-]> >gv
endif

" Indents (=) the entire file.
nmap <leader>= :call Preserve("normal gg=G")<CR>

" Deletes trailing whitespace for the entire file.
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>

" Show syntax highlighting groups for word under cursor
" (no luck putting the function in funrc.vim)
nmap <leader>g :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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
let g:CommandTMatchWindowReverse=1
let g:CommandTMaxHeight=30
let g:CommandTCancelMap='<esc>'
set wildignore+=*.class,*.o,*.obj,*/target/*

" look for ack in home/bin
" TODO: figure out a good system for having ack installed somwhere this plugin
" can find it every time. maybe install it in the vimfiles directory
" or figure out how to use $HOME/bin from the 'let blah' variables
"  let g:ackprg="perl C:\\cygwin\\home\\p054441\\bin\\ack -H --nocolor --nogroup --column"
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1

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

nmap <leader>c<space> <Plug>NERDCommenterToggle
vmap <leader>c<space> <Plug>NERDCommenterToggle

" map <F2> to toggle NERDTree
nnoremap <silent> <F2> :NERDTreeToggle<cr>
inoremap <silent> <F2> <ESC>:NERDTreeToggle<cr>

" map <F3> to show/close YankRing buffer
" TODO: it would be cool if when you F3 from insert mode it would go back to
" insert mode after you paste
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" map <F4> to toggle Tagbar
nnoremap <silent> <F4> :TagbarToggle<cr>
inoremap <silent> <F4> <ESC>:TagbarToggle<cr>

" map <F5> to toggle Gundo
nnoremap <silent> <F5> :GundoToggle<CR>
inoremap <silent> <F5> <ESC>:GundoToggle<CR>

nmap <silent> <Leader><space> :BufExplorer<CR>

" Put search item at the top of the screen
nnoremap <A-n>   nzt
nnoremap <A-S-n> Nzt

" TODO: install the syntastic plugin for realtime syntax checking
" TODO: figure out how to run unit tests without exiting vim with quickfix etc.

