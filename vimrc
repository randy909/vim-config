" To use create a (.|_)gvimrc file in $HOME that contains a line like this:
" (you could do something similar with symlinks but it doesn't work well on
" windows with cygwin)
"  source $HOME/.vim/vimrc
" or for windows:
"  source $HOME/vimfiles/vimrc

" source the files living next to this one
source <sfile>:p:h/settings.vim
source <sfile>:p:h/mappings.vim
source <sfile>:p:h/funrc.vim

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

