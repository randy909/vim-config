" To use create a .gvimrc file in $HOME that contains a line like this:
"  source $HOME/.vim/gvimrc
" or on windows:
"  source $HOME/vimfiles/gvimrc

" TODO: understand everything in this file
" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

"set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" TODO: does this change anything? seems like the default now...
" I like highlighting strings inside C comments
let c_comment_strings=1

" For Win32 version, have "K" lookup the keyword in a help file
"if has("win32")
"  let winhelpfile='windows.hlp'
"  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
"endif

" Aethsetics
set guifont=consolas

" Control window size
set lines=60
set columns=130

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar

