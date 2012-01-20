" Description: Result window implementation for VoraX
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_rwin")
  finish
endif

" Mark as loaded
let s:vorax_rwin = 1

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

runtime! vorax/lib/vim/vorax_utils.vim
runtime! vorax/lib/vim/vorax_dblayer.vim

let s:interface = Vorax_GetInterface()
let s:tk_utils = Vorax_UtilsToolkit()
let s:tk_db = Vorax_DbLayerToolkit()

" The rwin object reference
let s:rwin = {'last_statement' : {'cmd' : '', 'type' : '', 'frombuf' : 0} }

" This variable is used internally when results from the
" interface are put back together
let s:last_truncated = 1

" This variable is used internally to determine the
" user input within the results window
let s:last_line = ""

" The name of the vorax results buffer
let s:vorax_result_bufname = "vorax-results"

" The log file name.
let s:log_file = substitute(
  \ fnamemodify(
            \ (exists('g:vorax_logging_dir') ? g:vorax_logging_dir : expand('$HOME')) . '/vorax_' . localtime() . '_' . getpid() . '.log',
            \ ':p:8'), 
  \ '\', '/', 'g')

" the event handler
let s:handler = Vorax_GetEventHandler()

" Displays the results window. This function is smart enough to
" figure out wherever or not this window has to be created or
" just focused.
function s:rwin.FocusResultsWindow(toggle) dict
  silent! call s:log.trace('start s:rwin.FocusResultsWindow()')
  let result_buf_nr = bufnr('^' . s:vorax_result_bufname . '$')
  silent! call s:log.debug('result_buf_nr='.result_buf_nr)
  if result_buf_nr == -1
    " the result buffer was closed, create a new one
    silent! exec g:vorax_resultwin_geometry . ' new'
    silent! exec "edit " .s:vorax_result_bufname
  else
    " is the buffer visible?
    let result_win_nr = bufwinnr(result_buf_nr)
    silent! call s:log.debug('result_win_nr='.result_win_nr)
    if result_win_nr == -1
      " it is not visible
      silent! exec g:vorax_resultwin_geometry . 'split'
      silent! exec "edit " .s:vorax_result_bufname
    else
      exec result_win_nr . "wincmd w"
      if a:toggle
      	close!
        return
      endif
    endif
  endif
  setlocal nobuflisted
  silent! call s:log.trace('end s:rwin.FocusResultsWindow()')
endfunction

" Reexecute the last executed statement
function s:ReExec()
  if !s:interface.more
    " only if no statement exec is in progress
    if s:rwin.last_statement.cmd != ""
      if s:rwin.last_statement.type == 'oracle'
        " a regular oracle statement
        call vorax#Exec(s:rwin.last_statement.cmd, 1, g:vorax_messages['executing'])
      elseif s:rwin.last_statement.type == 'vim'
        " a vim statement (these come especially from desc commands)
        exe s:rwin.last_statement.cmd
      endif
    else
      call s:tk_utils.EchoErr(g:vorax_messages['no_prev_stmt'])
    endif
  endif
endfunction

" Toggle notification for finished statements
function s:ToggleNotify()
  let g:vorax_monitor_end_exec = !g:vorax_monitor_end_exec
  if g:vorax_monitor_end_exec
  	echo g:vorax_messages['notification_start']
  else
  	echo g:vorax_messages['notification_stop']
  endif
endfunction

function s:RegisterKeys()
  if g:vorax_key_for_toggle_logging != ""
    exe "noremap <buffer> " . g:vorax_key_for_toggle_logging . " :call <SID>ToggleLogging()<cr>"
  endif
  if g:vorax_key_for_toggle_notify != ""
    exe "noremap <buffer> " . g:vorax_key_for_toggle_notify . " :call <SID>ToggleNotify()<cr>"
  endif
  noremap <buffer> R :call <SID>ReExec()<cr>
  call s:tk_utils.CreateStandardMappings()
  " User defined mappings
  call s:handler.rwin_register_keys()
endfunction

" Usually called after executing something and
" the results has to be displayed. Basically, this function
" opens/focuses the results window. If monitor=1 then it 
" registers the monitor which will further populate the
" results buffer.
function s:rwin.ShowResults(monitor) dict
  silent! call s:log.trace('start of s:ShowResults')
  call self.FocusResultsWindow(0)
  " clear the result window?
  if g:vorax_resultwin_clear
    normal gg"_dG
  endif
  normal G$
  setlocal updatetime=50
  setlocal winfixheight
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal nowrap
  setlocal foldcolumn=0
  setlocal nospell
  setlocal nonu
  setlocal cursorline
  setlocal modifiable
  exe 'setlocal statusline=%!Vorax_RwinStatusLine()'
  call s:RegisterKeys()
  " highlight errors
  match ErrorMsg /^\(ORA-\|SP-\).*/
  redraw
  if g:vorax_inline_prompt
    echo g:vorax_messages['executing']
  else
    echo g:vorax_messages['executing'] . ' ' .g:vorax_messages['how_to_prompt']
  endif
  if a:monitor
    call s:StartMonitor()
  endif
  silent! call s:log.trace('end of s:ShowResults')
endfunction

" toggle the logging facility for the results window
function s:ToggleLogging()
  silent! call s:log.trace('start s:ToggleLogging()')
  if g:vorax_logging
    call s:StopLogging()
  else
    call s:StartLogging()
  endif
  silent! call s:log.trace('end s:ToggleLogging()')
endfunction

" Starts the monitor for the results window.
function s:StartMonitor()
  let s:start_time = localtime()
  call s:rwin.FocusResultsWindow(0)
  if g:vorax_inline_prompt
    inoremap <buffer> <cr> <esc>:call <SID>ProcessUserInput()<cr>
  else
    nmap <buffer> <cr> :call <SID>ProcessUserInput()<cr>
  endif
  nmap <buffer> <c-c> :call <SID>CancelExec()<cr>
  au VoraX CursorHold <buffer> call s:FetchResults()
  call feedkeys("f\e")  
  silent! call s:log.debug('RWin Monitor started.')
endfunction

" Notify user about an exec of a statement being finished.
function s:Notify()
  if g:vorax_monitor_end_exec || ( (g:vorax_notify_long_running > 0)
        \ && exists('s:start_time') 
        \ && ((localtime() - s:start_time) >= g:vorax_notify_long_running) )
    " notify user
    exe g:vorax_notify_command
  endif
endfunction

" Stop the monitor for the results window.
function s:StopMonitor()
  call s:rwin.FocusResultsWindow(0)
  mapclear <buffer>
  imapclear <buffer>
  " still, the registered keys should remain
  call s:RegisterKeys()
  au VoraX CursorHold <buffer> call s:FetchResults()
  autocmd! VoraX CursorHold <buffer>
  silent! call s:log.debug('RWin Monitor stopped.')
endfunction

" This function is called by the monitor (aka CursorHold autocmd)
" which incrementally fills in the results window.
function s:FetchResults()
  let result = s:interface.read() 
  if len(result) > 0
    if s:last_truncated
      " if the previous line was truncated, just merge it
      " with the current one
      let s:last_line = getline('$') .result[0]
      call setline(line('$'), s:last_line)
      call s:rwin.LogStuff(result[0] . "\n")
      call remove(result, 0)
    else
      call s:rwin.LogStuff("\n")
    endif
    if len(result) > 0
      call append(line('$'), result)
      let s:last_line = result[-1]
      " log the result
      if g:vorax_logging
        call s:rwin.LogStuff(join(result, "\n"))
      endif
    endif
    let s:last_truncated = s:interface.truncated
    normal G
  endif
  " show progress informationn... a redraw is needed
  redraw
  echon g:vorax_messages['executing'] . (g:vorax_inline_prompt ? " " : " " . g:vorax_messages['how_to_prompt']) . " " . s:tk_utils.BusyIndicator()
  if (!s:interface.more || s:interface.last_error != '')
    " no more data from the interface... it's safe to stop monitoring
    call s:StopMonitor()
    " maybe a connect statement was issued which means the connected user@db
    " could be different... just in case, set the title
    let title = ''
    if s:interface.last_error == '' && g:vorax_update_title
      let title = s:tk_db.ConnectionOwner()
      let &titlestring = title
      if title !~ '^[^@]\+@[^@]\+$'
        " mark it as disconnected
        let s:tk_db.connected = 0
      endif
    endif
    " flush log
    call s:FlushLog()
    " rebuild vorax db explorer
    call Vorax_RebuildDbExplorer()
    " show compilation errors, if any
    call vorax#ShowLastCompileErrors()
    if g:vorax_resultwin_clear
      " because we clear the window we do not want two empty lines
      " at the very beginning of the result window
      let s:last_truncated = 1
    else
      " this means the result is appended to the content of the
      " result window therefore we need an empty line above
      let s:last_truncated = 0
    endif
    " Notify the user about this being done
    call s:Notify()
    " invoke after display
    call s:handler.rwin_after_spit()
    " restore focus
    if g:vorax_restore_focus
      let wnr = bufwinnr(s:rwin.last_statement.frombuf)
      if wnr != -1
        " focus the exec buffer only if it's still open
        exe wnr . "wincmd w"
      endif
    endif
    " set status
    redraw
    echo g:vorax_messages['done']
  else
    " this is an workaround to automatically simulate a key stroke and, as such,
    " to trigger the CursorHold autocommand
    call feedkeys("f\e")  
  endif
endfunction

" Flushes the log buffer.
function s:FlushLog()
  if g:vorax_logging
    ruby <<EOF
    begin
      $log.flush if defined?($log)
    rescue 
    end
EOF
  endif
endfunction

" Write the provided text into the log
function s:rwin.LogStuff(text) dict
  let defined = 0
  ruby <<EOF
    if defined?($log)
      VIM::command('let defined = 1')
    end
EOF
  if g:vorax_logging
    if !defined
      call s:StartLogging()
    endif
    " write output line by line
    ruby <<EOF
      $log.print(VIM::evaluate('a:text'))
EOF
  endif
endfunction

" Starts the logging feature for the result window.
function s:StartLogging()
  let error = ""
  ruby <<EOF
    $log = File.new(VIM::evaluate('s:log_file'), 'a') rescue VIM::command("let error='" + $!.message.gsub(/'/, "''") + "'")
EOF
  if error == ""
    let g:vorax_logging = 1
    redraw
    echo s:tk_utils.Translate(g:vorax_messages['start_log'], s:log_file)
    silent! call s:log.debug('RWin Logging started in ' . s:log_file)
  else
    silent! call s:log.error('RWin Logging error: ' . error)
    call s:tk_utils.EchoErr(s:tk_utils.Translate(g:vorax_messages['error_log'], error))
  endif
endfunction

" Stops the logging for the result window
function s:StopLogging()
  let error = ""
  ruby <<EOF
    if defined?($log)
      $log.close rescue VIM::command("let error='" + $!.message.gsub(/'/, "''") + "'")
    end
EOF
  if error == ""
    let g:vorax_logging = 0
    redraw
    echo s:tk_utils.Translate(g:vorax_messages['stop_log'])
    silent! call s:log.debug('RWin Logging stopped.')
  else
    silent! call s:log.error('RWin Stop Logging error: ' . error)
    call s:tk_utils.EchoErr(error)
  endif
endfunction

" Spit the provided output into the result window.
function s:rwin.SpitOutput(output) dict
  " spit the output into the result window
  call self.ShowResults(0)
  " clear the result window?
  if g:vorax_resultwin_clear
    normal gg"_dG
    let index = 0
  else
    let index = line('$')
  endif
  normal G$
  call append(index, a:output)
  " scroll the window
  normal G$
  " if logging enabled then log
  if g:vorax_logging
    " an empty line just to nicely separate consequent execs
    call self.LogStuff("\n")
    " log content
    for line in a:output
      call self.LogStuff(line . "\n")
    endfor
    " flush log
    call s:FlushLog()
  endif
  call s:Notify()
  " invoke after display
  call s:handler.rwin_after_spit()
  " restore focus
  if g:vorax_restore_focus
    let wnr = bufwinnr(s:rwin.last_statement.frombuf)
    if wnr != -1
      " focus the exec buffer only if it's still open
      exe wnr . "wincmd w"
    endif
  endif
endfunction

" This function is used to get input from the user. Most
" of the time is about sqlplus ACCEPT like commands. Determining
" the user input is quite picky because in vim there's no efficient
" way of finding what was changed in a buffer therefore this function 
" simply assumes that the inputed text is whatever follows the text from the
" last line before entering in insert mode.
function! s:ProcessUserInput()
  " process user input only if a statement is currently
  " executing.
  if s:interface.more
    let input = ""
    if g:vorax_inline_prompt
      " accept input just on the last line
      if line('.') == line('$')
        let line = getline('$')
        let input = strpart(line, len(s:last_line))
        call append(line('$'), "")
      else
        call s:tk_utils.EchoErr(g:vorax_messages['prompt_on_last_line_only'])
        " go to the last line
        stopinsert
        normal UG$
        " enter in insert mode just after the prompt is
        startinsert!
        return
      endif
    else
      let line = getline('$')
      let input = input(line == "" ? "?: " : line)
      call setline(line('$'), line . input)
      call append(line('$'), "")
    endif
    silent! call s:log.debug('User input: ' . input)
    call s:interface.send(input)
  endif
endfunction

" Cancel the currently executing statement
function! s:CancelExec()
  silent! call s:log.debug('Cancel requested.')
  let response = input(g:vorax_messages['cancel_confirmation'] . " (y/[N]): ")
  if response =~? '\s*y\s*'
    if s:interface.more && !s:interface.cancel()
      " if cancel operation from the interface tells that it's not safe to continue
      " with the current session, inform the user and ask him/her for a new connection
      let response = input(s:tk_utils.Translate(g:vorax_messages['abort_session'],  
                        \ s:tk_db.cdata['user'] . '@' . s:tk_db.cdata['db']) . " ([y]/n): ")
      if response =~? '\s*y\s*' || response == ""
        " build up a connection string from the last credentials
        let cs = s:tk_db.cdata['user'] . '/"' . substitute(s:tk_db.cdata['passwd'], '^"\|"$', '', 'g') . '"'
        if s:tk_db.cdata['osauth'] 
          let cs .= " " . s:tk_db.cdata['db']
        else
          let cs .= "@". s:tk_db.cdata['db']
        endif
        " it doesn't make sense to continue monitoring
        call s:StopMonitor()
        " initiate a new connection
        call vorax#Connect(cs)
      endif
    endif
  endif
endfunction

" Used for rwin statusbar
function Vorax_RwinStatusLine()
  return ' ' . &titlestring . ' | Position: %l/%L - %P%= Logging: ' . 
    \ (g:vorax_logging ? 'ON' : 'OFF') . ' | Monitoring: ' . 
    \ (g:vorax_monitor_end_exec ? 'ON' : 'OFF') . ' '
endfunction

" Get the rwin object
function Vorax_RwinToolkit()
  return s:rwin
endfunction
