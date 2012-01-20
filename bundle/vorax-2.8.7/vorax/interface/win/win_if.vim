" Description: Windows Interface for VoraX
" Mainainder: Alexandru Tică <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:win_interface")
  finish
endif

" flag to signal this source was loaded
let s:win_interface = 1

if has('win32') || has('win64')

  " the vorax ruby lib location
  let s:vrx_lib = expand('<sfile>:h:p') . '/vorax.rb'

  " a temporary file name for packing
  let s:temp_in = fnamemodify(tempname(), ':p:8')

  " the end marker
  let s:end_marker = '-- !vorax-end'
  
  "load ruby library
  exe 'ruby require "' . substitute(s:vrx_lib, '\', '/', 'g') . '"'

  "get common interface object
  let s:common_if = Vorax_GetCommonInterface()

  " define the interface object
  let s:interface = {'more' : 0, 'truncated' : 0, 'last_error' : "", 'connected_to' : '@'}

  function s:interface.startup() dict
    " stop the interface if already running
    call self.shutdown()
    " startup the interface
    let self.last_error = ""
    ruby $vorax_if = popen("sqlplus /nolog") rescue VIM::command("let self.last_error='" + $!.message.gsub(/'/, "''") + "'")
  endfunction

  function s:interface.send(command) dict
    call s:common_if.send(self, a:command)
  endfunction

  function s:interface.cancel() dict
    " abort fetching data through the interface
    let self.more = 0
    " command line version of sqlplus doesn't support succesive
    " cancels of running statements. This is so sad... If you
    " have a running statement and press CTRL+C  once will work,
    " but on the second CTRL+C will simply kill the sqlplus
    " instance. That's the case just in Windows... Even it's a
    " huge drawback, the cancel operation is implemented quite
    " rude: kill running sqlplus process and start a new one.
    silent! ruby Process.kill(9, $vorax_if.pid)
    " return the status of the connection: 0 means it's not
    " safe to continue with this session and a reconnect must be
    " done; 1 means the session was successfully canceled and
    " it's safe to continue with this session.
    return 0
  endfunction

  function s:interface.read() dict
    return s:common_if.read(self, s:end_marker)
  endfunction

  function s:interface.pack(command) dict
    return s:common_if.pack(self, a:command, s:end_marker, s:temp_in)
  endfunction

  function s:interface.convert_path(path) dict
    return a:path
  endfunction

  function s:interface.mark_end() dict
    call self.send(s:common_if.eof(s:end_marker))
  endfunction

  function s:interface.shutdown() dict
    call s:common_if.shutdown(s:temp_in)
  endfunction

  " register the interface
  call Vorax_RegisterInterface(s:interface)

endif
