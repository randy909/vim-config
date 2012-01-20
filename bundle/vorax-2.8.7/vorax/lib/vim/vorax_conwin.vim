" Description: Connection window implementation for VoraX
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_cwin")
  finish
endif

" Mark as loaded
let s:vorax_cwin = 1

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

" The rwin object reference
let s:cwin = {}

" The name of the file storing the connection profiles
let s:conn_file = substitute(fnamemodify(expand('$HOME'), ':p:8') . '/_vorax_connections', '\\', '/', 'g')

" Displays the connection window. 
function s:cwin.FocusWindow() dict
  silent! call s:log.trace('start s:cwin.FocusWindow()')
  silent! call s:log.debug('s:conn_file=' . s:conn_file)
  let buf_nr = bufnr('_vorax_connections$')
  silent! call s:log.debug('buf_nr='.buf_nr)
  if buf_nr == -1
    " the result buffer was closed, create a new one
    silent! exec g:vorax_connwin_geometry . ' new'
    silent! exec "edit " .s:conn_file
  else
    " is the buffer visible?
    let win_nr = bufwinnr(buf_nr)
    silent! call s:log.debug('win_nr='.win_nr)
    if win_nr == -1
      " it is not visible
      silent! exec g:vorax_connwin_geometry . 'split'
      silent! exec "edit " .s:conn_file
    else
      exec win_nr . "wincmd w"
      setlocal hid
      close!
      return
    endif
  endif
  setlocal winfixwidth
  setlocal noswapfile
  setlocal nowrap
  setlocal foldcolumn=0
  setlocal nospell
  setlocal nonu
  setlocal nobuflisted
  setlocal cursorline
  setlocal hid
  set syntax=sql

  if !filereadable(s:conn_file)
    " first time opening this window
    let sample = ["--add your connection", 
                \ "--profies here", 
                \ "", 
                \ "--production",
                \ "--(! means important)",
                \ "!scott@prod",
                \ "",
                \ "--development",
                \ "scott@dev",
                \ "",
                \ "--test",
                \ "scott@test"]
    call append(0, sample)
    normal gg
    " save profile file
    silent :w!
  endif
  " define mappings
  nmap <buffer> <cr> :call <SID>CreateConn()<cr>
  nmap <buffer> q :close!<cr>
  " highlight production connections
  match ErrorMsg /^\s*!.*/
  silent! call s:log.trace('end s:cwin.FocusWindow()')
endfunction

function s:CreateConn()
  let con = getline('.')
  if con !~ '^\s*--'
    call vorax#Connect(substitute(con, '^\s*!', '', ''))
  endif
endfunction

" Get the cwin object
function Vorax_CwinToolkit()
  return s:cwin
endfunction
