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

let mapleader = ","

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

execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on

" This makes yankstack play nice with surround
" i.e. it lets surround map S in visual mode
call yankstack#setup()

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

" syntax highlighting stuff
set t_Co=256 " enable more colors for vim, gvim ignores it
syntax on
call togglebg#map("<F8>")
"let g:solarized_contrast="high"
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

autocmd BufNewFile,BufRead *.hjs set filetype=html

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


" Mappings

" use ; for : too so I don't have to hit <shift>
nnoremap ; :
vnoremap ; :
nnoremap q; q:

" replace ; and , with <space> and <shift-space>
nnoremap <space> ;
nnoremap <S-space> ,

" make alt-j/k go up/down by screen line instead of file line
nnoremap <A-j> gj
nnoremap <A-k> gk

" Map <C-hjkl> to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map <C-l> to complete line (workaround for YouCompleteMe always having
" completion started)
inoremap <C-l> <C-x><C-l>

" Clear search highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Give Textmate's indentation commands a whirl
if has("gui_running")
  nmap <A-[> <<
  nmap <A-]> >>
  vmap <A-[> <gv
  vmap <A-]> >gv
endif

" Put search item at the top of the screen
nnoremap <A-n>   nzt
nnoremap <A-S-n> Nzt

" command-<num> jumps to tab just like chrome, iterm, etc.
nnoremap <D-1> 1gt
nnoremap <D-2> 2gt
nnoremap <D-3> 3gt
nnoremap <D-4> 4gt
nnoremap <D-5> 5gt
nnoremap <D-6> 6gt
nnoremap <D-7> 7gt
nnoremap <D-8> 8gt
nnoremap <D-9> 9gt

" Use ctrl-j/k for up/down in autocomplete menu
" Unfortunately there are no direct mappings for just autocomplete menu mode
" These seem to be squashed by YouCompleteMe or Ultisnips for some reason
" inoremap <C-j> <C-n>
" inoremap <C-k> <C-p>

" Plugin config

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

" CommandT prefs
let g:CommandTMatchWindowReverse=1
let g:CommandTMaxHeight=30
let g:CommandTCancelMap='<esc>'
set wildignore+=*.class,*.o,*.obj,*/target/*,node_modules,dist

" look for ack in home/bin
" TODO: figure out a good system for having ack installed somwhere this plugin
" can find it every time. maybe install it in the vimfiles directory
" or figure out how to use $HOME/bin from the 'let blah' variables
"  let g:ackprg="perl C:\\cygwin\\home\\p054441\\bin\\ack -H --nocolor --nogroup --column"
let g:ackprg="ack -H --nocolor --nogroup --column"

" Easymotion mappings
let g:EasyMotion_mapping_f = '<leader>f'
let g:EasyMotion_mapping_F = '<leader>F'
let g:EasyMotion_mapping_j = '<leader>j'
let g:EasyMotion_mapping_k = '<leader>k'
" doubtful i'll ever use these, we'll see
let g:EasyMotion_mapping_t = '<leader><leader>t'
let g:EasyMotion_mapping_T = '<leader><leader>T'
let g:EasyMotion_mapping_w = '<leader><leader>w'
let g:EasyMotion_mapping_W = '<leader><leader>W'
let g:EasyMotion_mapping_b = '<leader><leader>b'
let g:EasyMotion_mapping_B = '<leader><leader>B'
let g:EasyMotion_mapping_e = '<leader><leader>e'
let g:EasyMotion_mapping_E = '<leader><leader>E'
let g:EasyMotion_mapping_n = '<leader><leader>n'
let g:EasyMotion_mapping_N = '<leader><leader>N'

let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_suppress_keymaps = 1
let g:buffergator_sort_regime = 'mru'
nnoremap <silent> <Leader><space> :BuffergatorToggle<CR>

" map <F2> to toggle NERDTree
nnoremap <silent> <F2> :NERDTreeToggle<cr>
inoremap <silent> <F2> <ESC>:NERDTreeToggle<cr>

" Yankstack config
nnoremap <silent> <F3> :Yanks<cr>
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" map <F4> to toggle Tagbar
nnoremap <silent> <F4> :TagbarToggle<cr>
inoremap <silent> <F4> <ESC>:TagbarToggle<cr>

" map <F5> to toggle Gundo
nnoremap <silent> <F5> :GundoToggle<CR>
inoremap <silent> <F5> <ESC>:GundoToggle<CR>

" map <leader>s to format code
nnoremap <leader>s :Autoformat<CR><CR>
" AutoFormat won't take a range but gq will use it instead of doing the
" default crazy behavior
vmap <leader>s gq

" TODO: fix up this powerline/airline thing. need to switch file type for pwd
" or something like that... see what i had here for powerline prior to
" switching to airline
" Powerline config
" Make sure you're using a powerline patched font (github has some but had to
" patch the font myself on OSX to get it working)
" let g:Powerline_symbols = 'fancy'
" call Pl#Theme#ReplaceSegment('fileformat', 'pwd')
" call Pl#Theme#RemoveSegment('fileencoding')
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Close hidden fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Ultisnips conf
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" TODO: figure out how to run unit tests without exiting vim with quickfix etc.

