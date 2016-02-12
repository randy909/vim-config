" To use create a (.|_)gvimrc file in $HOME that contains a line like this:
" (you could do something similar with symlinks but it doesn't work well on
" windows with cygwin)
"  source $HOME/.vim/gvimrc
" or on windows:
"  source $HOME/vimfiles/gvimrc
" Note: on cygwin the win32 gvim will read the .gvimrc and .vimrc files,
" it doesn't have to be _gvimrc/_vimrc.

" TODO: understand everything in this file
" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

"set ch=2               " Make command line two lines high

set mousehide           " Hide the mouse when typing text
"set mousefocus          " activate window with mouse over it automatically

" TODO: does this change anything? seems like the default now...
" I like highlighting strings inside C comments
let c_comment_strings=1

" For Win32 version, have "K" lookup the keyword in a help file
"if has("win32")
"  let winhelpfile='windows.hlp'
"  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
"endif

" Aethsetics
if has("win32")
  set guifont=consolas
elseif has ("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Ubuntu\ Mono\ derivative\ Powerline:h14
"    this one doesn't have italics or bold
"    set guifont=Menlo\ for\ Powerline:h12
"    this one has italics and the powerline stuff seems to work.
"    I'm skeptical it would continue working after a reboot though.
"    Looks similar to ubuntu mono but it's just not as pretty.
"    set guifont=Menlo:h12
  else
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  endif
endif

" Control window size
set lines=79
set columns=130

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

set t_vb= " don't flash window even in gui mode

if exists('*HexHighlight()')
  nmap <leader>h :call HexHighlight()<Return>
endif

colorscheme solarized
