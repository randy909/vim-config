" To use create a (.|_)gvimrc file in $HOME that contains a line like this:
" (you could do something similar with symlinks but it doesn't work well on
" windows with cygwin)
"  source $HOME/.vim/vimrc
" or for windows:
"  source $HOME/vimfiles/vimrc

source <sfile>:p:h/boot.vim

call plug#begin()
Plug 'Chiel92/vim-autoformat'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'godlygeek/tabular'
Plug 'henrik/vim-indexed-search'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'majutsushi/tagbar'
Plug 'marijnh/tern_for_vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'randy909/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/hexHighlight.vim'
Plug 'vim-scripts/keepcase.vim'
Plug 'wincent/Command-T'
call plug#end()

filetype plugin indent on

" This makes yankstack play nice with surround
" i.e. it lets surround map S in visual mode
call yankstack#setup()

call togglebg#map("<F8>")
set background=dark
let g:solarized_termcolors=256
let base16colorspace=256
colorscheme base16-default-dark

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
" use ag instead of ack if it's available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Easymotion mappings
let g:EasyMotion_mapping_f = '<leader>f'
let g:EasyMotion_mapping_F = '<leader>F'
let g:EasyMotion_mapping_j = '<leader>j'
let g:EasyMotion_mapping_k = '<leader>k'

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

