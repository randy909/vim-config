" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_utils")
  finish
endif

" mark as loaded
let s:vorax_utils = 1

let s:utils = {}

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

" print the provided error
function s:utils.EchoErr(msg) dict
  echohl WarningMsg
  echo a:msg
  echohl Normal
endfunction

" Returns an waiting indicator char in order to simulate
" somekind of busy marker.
function! s:utils.BusyIndicator() dict
  if !exists('s:vorax_status') || s:vorax_status == "|"
    let s:vorax_status = '/'
  elseif s:vorax_status == '/'
    let s:vorax_status = '-'
  elseif s:vorax_status == '-'
    let s:vorax_status = '\'
  elseif s:vorax_status == '\'
    let s:vorax_status = '|'
  endif
  return s:vorax_status
endfunction

" This function is used to replace placeholders from resource strings. The
" placeholder format is {#}
function! s:utils.Translate(rs, ...) dict
  let str = a:rs
  let i = 1
  while str =~ '{#}'
    if i > a:0
      " we're out of placeholder values
      break
    endif
    let str = substitute(str, '{#}', a:{i}, '')
    let i += 1
  endwhile
  return str
endfunction

" Get the content of the current buffer
function s:utils.BufferContent() dict
  let lines = getline(0, line('$'))
  let content = ""
  for line in lines
    let content .= line . "\n"
  endfor
  return content
endfunction

" this function returns 1 if the first char from a:str is lower,
" or 0 otherwise. It is used in completion functions to determine
" how the items should be returned: upper or lower.
function s:utils.IsLower(str) dict
  if a:str[0] == tolower(a:str[0])
    return 1
  else
    return 0
  endif
endfunction

" Get the position of the first or the last valid statement char. Mode
" can be: 'f' for forward, 'b' for backword. It returns an array of 
" [line, col]
function s:AdjustPosition(mode)
  silent! call s:log.trace('start of s:utils.AdjustPosition mode='.a:mode)
  let whichwrap_bak = &whichwrap
  set whichwrap+=<,>,h,l
  if a:mode == 'f'
    " forward search
    let last_line = line('$')
    while 1
      let cc = col(".")
      let cl = line(".")
      let line = getline(".")
      let syn = synIDattr(synIDtrans(synID(cl, cc, 1)), "name")  
      silent! call s:log.debug('cc='.cc.' cl='.cl.' line='.string(line).' syn='.syn)
      if (syn != 'Comment' && line[cc-1] != ' ' && cc <= len(line)) || (cc == col('$') && cl == last_line)
        break
      endif
      normal l
    endwhile
  elseif a:mode == 'b'
    while 1
      let cc = col(".")
      let cl = line(".")
      let line = getline(".")
      let syn = synIDattr(synIDtrans(synID(cl, cc, 1)), "name")  
      silent! call s:log.debug('cc='.cc.' cl='.cl.' line='.line.' syn='.syn)
      if (syn != 'Comment' && line[cc-1] != ' ' && cc >= 0) || (cc == 1 && cl == 1)
        break
      endif
      normal h
    endwhile
  endif
  exe 'set whichwrap=' . whichwrap_bak
endfunction

" Get the under cursor statemnt boundaries. It returns
" an array with [start_line, start_col, stop_line, stop_col, statement, relpos].
" The meaning of these values are:
" start_line => the line where the current statement begins
" start_col => the column where the current statement begins
" stop_line => the line where the current statement ends
" stop_col => the column where the current statement ends
" statement => the text of the statement
" relpos => the absolute position of the cursor witin the current statement
function s:utils.UnderCursorStatement(adjust) dict
  silent! call s:log.trace('start of s:utils.UnderCursorStatement')
  let whichwrap_bak = &whichwrap
  set whichwrap+=<,>,h,l
  let old_wrapscan=&wrapscan
  let &wrapscan = 0
  let old_ve = &ve
  silent! call s:log.debug('old_ve='.old_ve)
  set ve=
  let old_search=@/
  let old_line = line('.')
  let old_col = col('.')
  " start of the statement
  let start_line = 0
  let start_col = 0
  " end of the statement
  let stop_line = 0
  let stop_col = 0
  while (start_line == 0)
    let result = search(';\|^\s*\/\s*$', 'beW')
    silent! call s:log.debug('result first loop='.result)
    if result
      let syn = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")  
      silent! call s:log.debug('syn first loop='.syn)
      if syn == "Constant" || syn == 'Comment'
        " do  nothing
      else
        " if the delimitator is not within quotes or comments
        normal l
        let start_line = line('.')
        let start_col = col('.')
      endif
    else
      " set the begining of the statement at the very
      " beginning of the buffer content
      let start_line = 1
      let start_col = 1
    endif
  endwhile
  silent! call s:log.debug('after first loop: start_line='.start_line.' start_col='.start_col)
  while (stop_line == 0)
    let result = search(';\|^\s*\/\s*$', 'Wc')
    silent! call s:log.debug('result second loop='.result)
    if result
      let syn = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")  
      silent! call s:log.debug('syn second loop='.syn)
      let line = line('.')
      let col = col('.')
      if (syn == "Constant" || syn == "Comment") && ([line, col] != [line('$'), col('$')-1])
        " do nothing
        normal l
      else
        " if the delimitator is not within quotes or comments
        let stop_line = line
        let stop_col = col
      endif
    else
      " set the begining of the statement at the very
      " beginning of the buffer content
      normal G$
      let stop_line = line('.')
      let stop_col = col('.') 
    endif
  endwhile
  silent! call s:log.debug('after second loop: stop_line='.stop_line.' stop_col='.stop_col)
  if a:adjust
    " adjusting taking into account comments
    exe 'normal ' . start_line . 'G0'
    if start_col > 1
      exe 'normal ' . ( start_col - 1 ) . 'l'
    endif
    call s:AdjustPosition('f')
    let start_line = line('.')
    let start_col = col('.')
    silent! call s:log.debug('after adjusting forward: start_line='.start_line.' start_col='.start_col)
    exe 'normal ' . stop_line . 'G0'
    if stop_col > 1
      exe 'normal ' . ( stop_col - 1 ) . 'l'
    endif
    call s:AdjustPosition('b')
    let stop_line = line('.')
    if stop_col > 1
      let stop_col = col('.') - 1
    endif
    silent! call s:log.debug('after adjusting backward: stop_line='.stop_line.' stop_col='.stop_col)
  end
  " extract the actual statement
  let statement = ""
  for line in getline(start_line, stop_line)
    let statement .= line . "\n"
  endfor
  let statement = strpart(statement, start_col-1, strlen(statement) - (strlen(getline(stop_line)) - stop_col))
  " get rid of the final \n
  let statement = substitute(statement, '\n$', '', '')
  " restore the old pos
  call cursor(old_line, old_col)
  " compute relative pos
  let rel_line = old_line - start_line + 1
  let rel_pos = 1
  let i = 1
  let lines = split(statement, '\n', 1)
  for line in lines
    if i == rel_line
      let rel_pos += old_col - 1
      break
    else
      " we add 1 to count \n
      let rel_pos += strlen(line) + 1
    endif
    let i += 1
  endfor
  let &wrapscan=old_wrapscan
  let @/=old_search
  let retval = [start_line, start_col, stop_line, stop_col, statement, rel_pos]
  exe 'set whichwrap=' . whichwrap_bak
  exe 'set ve=' . old_ve
  silent! call s:log.trace('end of s:utils.UnderCursorStatement: returned value=' . string(retval))
  return retval
endfunction

function s:utils.CreateStandardMappings() dict
  if g:vorax_key_for_describe != ""
    if maparg(g:vorax_key_for_describe, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_describe . " :VoraxDescribe<cr>"
    endif

    if maparg(g:vorax_key_for_describe, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_describe " :VoraxDescribeVisual<cr>"
    endif
  endif

  if g:vorax_key_for_describe_verbose != ""
    if maparg(g:vorax_key_for_describe_verbose, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_describe_verbose . " :VoraxDescribeVerbose<cr>"
    endif

    if maparg(g:vorax_key_for_describe_verbose, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_describe_verbose . " :VoraxDescribeVerboseVisual<cr>"
    endif
  endif

  if g:vorax_key_for_goto_def != "" && maparg(g:vorax_key_for_goto_def, 'n') == ""
    exe "nmap <buffer> <unique> " . g:vorax_key_for_goto_def . " :VoraxGotoDefinition<cr>"
  endif

  " mapping for get help for the word under cursor
  if g:vorax_key_for_oradoc_under_cursor != ""
    exe "nmap <buffer> " . g:vorax_key_for_oradoc_under_cursor . " :call vorax#OradocSearch(expand('<cword>'))<cr>"
    exe "xmap <buffer> " . g:vorax_key_for_oradoc_under_cursor . " :call vorax#OradocSearch(vorax#SelectedBlock())<cr>"
  end
endfunction

" Create the mappings for a vorax buffer.
function s:utils.CreateBufferMappings() dict
  " defines vorax mappings for the current buffer
  if g:vorax_key_for_fuzzy_search != "" && maparg(g:vorax_key_for_fuzzy_search, 'i') == ""
    exe "imap <buffer> <unique> " . g:vorax_key_for_fuzzy_search . " <Esc>:VoraxSearch<cr>"
  endif

  if g:vorax_key_for_exec_sql != "" 
  	if maparg(g:vorax_key_for_exec_sql, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_exec_sql . " :VoraxExecUnderCursor<cr>"
    endif

    if maparg(g:vorax_key_for_exec_sql, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_exec_sql . " :VoraxExecVisualSQL<cr>"
    endif
  endif

  if g:vorax_key_for_exec_one != ""
    if maparg(g:vorax_key_for_exec_one, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_exec_one . " :VoraxQueryVerticalLayout<cr>"
    endif

    if maparg(g:vorax_key_for_exec_one, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_exec_one . " :VoraxQueryVerticalLayoutVisual<cr>"
    endif
  endif

  if g:vorax_key_for_explain_plan != ""
    if maparg(g:vorax_key_for_explain_plan, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_explain_plan . " :VoraxExplainUnderCursor<cr>"
    endif

    if maparg(g:vorax_key_for_explain_plan, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_explain_plan . " :VoraxExplainVisualSQL<cr>"
    endif
  endif

  if g:vorax_key_for_explain_only != ""
    if maparg(g:vorax_key_for_explain_only, 'n') == ""
      exe "nmap <buffer> <unique> " . g:vorax_key_for_explain_only . " :VoraxExplainOnlyUnderCursor<cr>"
    endif

    if maparg(g:vorax_key_for_explain_only, 'v') == ""
      exe "xmap <buffer> <unique> " . g:vorax_key_for_explain_only . " :VoraxExplainOnlyVisualSQL<cr>"
    endif
  endif

  if g:vorax_key_for_exec_buffer != "" && maparg(g:vorax_key_for_exec_buffer, 'n') == ""
    exe "nmap <buffer> <unique> " . g:vorax_key_for_exec_buffer . " :VoraxExecBuffer<cr>"
  endif

  call self.CreateStandardMappings()

  " User defined mappings
  let handler = Vorax_GetEventHandler()
  call handler.buf_register_keys()
endfunction

" Returns 1 if the provided filename is a vorax managed one,
" 0 otherwise. A file is considered vorax managed if its
" extension is within g:vorax_db_explorer_file_extensions or
" is 'sql'
function s:utils.Managed(file) dict
  let ext = fnamemodify(a:file, ':e')
  for item in g:vorax_dbexplorer_file_extensions
    if ext ==? item.ext || ext ==? 'sql'
      return 1
    endif
  endfor
  return 0
endfunction

" When a db object is about to be opened, we don't want the edit window
" to be layed out randomly, or ontop of special windows like the results
" window. This procedure finds out a suitable window for opening the
" db object. If it cannot find any then a new split will be performed.
function s:utils.FocusCandidateWindow() dict
  let winlist = []
  " we save the current window because the after windo we may end up in
  " another window
  let original_win = winnr()
  " iterate through all windows and get info from them
  windo let winlist += [[bufnr('%'),  winnr(), &buftype]]
  for w in winlist
    if w[2] == "nofile" || w[2] == 'quickfix' || w[2] == 'help'
      " do nothing
    else
      " great! we just found a suitable window... focus it please
      exe w[1] . 'wincmd w'
      return
    endif
  endfor
  " if here, then no suitable window was found... we'll create one
  " first of all, restore the old window
  exe original_win . 'wincmd w'
  " split a new window taking into account where the dbexplorer is
  let settings = VrxTree_GetSettings(bufname('%'))
  if settings['vertical']
    " compute how large this window should be
    let span = winwidth(0) - settings['minWidth']
    if settings['side'] == 1
      let splitcmd = 'topleft ' . (span > 0 ? span : "") . 'new'
    elseif settings['side'] == 0
      let splitcmd = 'botright ' . (span > 0 ? span : "") . 'new'
    endif
  else
    " compute how tall this window should be
    let span = winheight(0) - settings['minHeight']
    if settings['side'] == 1
      let splitcmd = 'topleft vertical ' . (span > 0 ? span : "") . 'new'
    elseif settings['side'] == 0
      let splitcmd = 'botright vertical ' . (span > 0 ? span : "") . 'new'
    endif
  endif
  exe splitcmd
endfunction

" Get the corresponding file extension for the provided
" object type. The file extension is returned according to
" the g:vorax_dbexplorer_file_extensions variable.
function s:utils.ExtensionForType(type) dict
  for item in g:vorax_dbexplorer_file_extensions
    if item.type ==? a:type
      return item.ext
    endif
  endfor
  return 'sql'
endfunction

" Get the tools object
function Vorax_UtilsToolkit()
  return s:utils
endfunction

