" This file is for settings that do not depend on any plugins
"
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader = ","

" source the files living next to this one
source <sfile>:p:h/mswin.vim

" My own halfway point between behave mswin and xterm
set mousemodel=popup " right click should popup not extend
set keymodel=startsel,stopsel " allow shift-<end> style selection
set selection=inclusive " include last char on line when mouse selecting

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

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
set ttimeoutlen=10     " make vim exit search/visual with <exc> quickly
set ttyfast            " draw smoother if terminal is fast
set visualbell t_vb=   " turn off bells in all forms
set laststatus=2       " always show a status bar (good for powerline
set shell=/bin/sh      " fixes permission issue when using fish
set noequalalways      " make window splitting not resize everything
set splitbelow         " make new horizontal window go below
set splitright         " make new vertical window go right

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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

" syntax highlighting stuff
set t_Co=256 " enable more colors for vim, gvim ignores it
syntax on
