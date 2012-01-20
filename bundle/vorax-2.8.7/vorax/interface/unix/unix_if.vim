" Description: Unix Interface for VoraX
" Mainainder: Alexandru Tică <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:unix_interface")
  finish
endif

" flag to signal this source was loaded
let s:unix_interface = 1

if has('unix') && !has('win32unix')
  
  " the vorax ruby lib location
  let s:vrx_lib = expand('<sfile>:h:p') . '/vorax.rb'

  " a temporary file name for packing
  let s:temp_in = fnamemodify(tempname(), ':p:h') . '/vorax_in.sql'

  " the end marker
  let s:end_marker = '-- !vorax-end'
  
  "load ruby library
  exe 'ruby require "' . s:vrx_lib . '"'

  "get common interface object
  let s:common_if = Vorax_GetCommonInterface()

  " define the interface object
  let s:interface = {'more' : 0, 'truncated' : 0, 'last_error' : "", 'connected_to' : '@'}

  function s:interface.startup() dict
    " stop the interface if already running
    call self.shutdown()
    " startup the interface
    let self.last_error = ""
    let content = "host stty -echo\n"
    let content .= s:common_if.eof(s:end_marker)
    let execcmd = self.pack(content)
    ruby $vorax_if = UnixPIO.new("sqlplus /nolog " + VIM::evaluate('execcmd')) rescue VIM::command("let self.last_error='" + $!.message.gsub(/'/, "''") + "'")
    " output is expected
    let self.more = 1
    " we don't want the above commands to be shown therefore
    " just consume the current output
    if self.last_error == ""
      let step = 1
      while step < 100
        call self.read()
        if !self.more || self.last_error != "" 
          break
        endif
        sleep 50m
        let step += 1
      endwhile
      if step == 100 && self.more
        " Give up after 100 retries
        let self.last_error = "Timeout on initializing interface."
      endif
    endif
  endfunction

  function s:interface.send(command) dict
    call s:common_if.send(self, a:command)
  endfunction

  function s:interface.cancel() dict
    " abort fetching data through the interface
    let self.last_error = ""
    silent! ruby Process.kill('INT', $vorax_if.pid)
    "silent! ruby $vorax_if.write(VIM::evaluate('Eof()')
    call self.send(s:common_if.eof(s:end_marker))
    if self.last_error == ""
      " the session was successfully cancelled
      return 1
    else
      " the session was not successfully cancelled
      return 0
    endif
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
