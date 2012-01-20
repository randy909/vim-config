" Description: Common Interface utilities for VoraX
" Mainainder: Alexandru Tică <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:common_if_loaded")
	finish
endif
let s:common_if_loaded = 1

" The object which provides common functions to OS iterface
" implementators. Basically, the main reason of having this is
" to avoid spreading duplicate code among all scripts which
" provides OS interfaces.
let s:common_if = { }

" the last read line
let s:last_line = ""

" This function get the code needed to be executed into a
" sqlplus session in order to mark the end of a call. The
" end_marker parameter is a custom interface defined label
" which is used to recognise the end of the call.
function s:common_if.eof(end_marker) dict
  let eof = "\nprompt " . a:end_marker . "\n"
  return eof
endfunction

" This function is used to send a command to the provided
" interface. It assumes the 'vorax_if' ruby object is already
" initialized by the interface.startup method therefore you
" should not call this function before that.
function s:common_if.send(interface, command) dict
  let a:interface.last_error = ""
  " send stuff to interface
  ruby $vorax_if.write(VIM::evaluate('a:command') + "\n") rescue VIM::command("let a:interface.last_error='" + $!.message.gsub(/'/, "''") + "'")
  " signal that we might have output
  let a:interface.more = 1
endfunction

" Read a chunck of data from the provided interface, until the
" given end_marker. This function assumes that the $vorax_if
" ruby object is already initialized. The output is returned as
" an array of strings.
function s:common_if.read(interface, end_marker) dict
  " read output
  let output = []
  ruby << EOF
    begin
      if buffer = $vorax_if.read
        end_marker = VIM::evaluate('a:end_marker')
        end_pattern = Regexp.new(end_marker + '$')
        lines = buffer.gsub(/\r/, '').split(/\n/)
        lines.each_with_index do |line, i| 
          if VIM::evaluate('a:interface.truncated') == 1
            last_line = VIM::evaluate('s:last_line') + line
          end
          if end_pattern.match(last_line) || end_pattern.match(line)
            VIM::command('let a:interface.more = 0')
            remaining = ''
            remaining = lines[i+1..-1].join("\n") if i < lines.size
            # consume the output after the marker
            tail = ""
            remaining += tail while tail = $vorax_if.read && tail.length > 0
            if remaining =~ /\#([^@]*@[^#]*)\#$/
              VIM::command("let a:interface.connected_to = '#{$~[1]}'")
            else
              VIM::command("let a:interface.connected_to = '@'")
            end
            break
          else
            l = line.gsub(/'/, "''")
            VIM::command('let s:last_line = \'' + l + '\'')
            VIM::command('call add(output, \'' + l + '\')')
          end
        end
        if buffer[-1, 1] == "\n"
          VIM::command('let a:interface.truncated = 0')
        else
          VIM::command('let a:interface.truncated = 1')
        end
      end
    rescue
      VIM::command("let a:interface.last_error='" + $!.message.gsub(/'/, "''") + "'")
    end
EOF
  return output
endfunction

" Pack the provided command into the given 'to_file' file and
" add the final 'end_marker' at the end. It returns the command
" which may be used in sqlplus to execute the packed command.
function s:common_if.pack(interface, command, end_marker, to_file) dict
  " remove trailing blanks from cmd
  let dbcommand = substitute(a:command, '\_s*\_$', '', 'g')
  " now, embed our command
  let content = dbcommand . "\n"
  " add the end marker
  let content .= self.eof(a:end_marker) 
  " write everything into a nice sql file
  call writefile(split(content, '\n'), a:to_file) 
  return '@' . a:interface.convert_path(a:to_file)
endfunction

" Shutdown the provided interface. It assumes the '$vorax_if'
" ruby object is already initialized. If the interface is
" using a temporary file then it may be provided here in order
" to be deleted as part of the cleanup process.
function s:common_if.shutdown(temp_file) dict
  " shutdown the interface
  silent! ruby <<EOF
    if $vorax_if
      Process.kill(9, $vorax_if.pid) 
      # wait for that process to exit
      begin
        100.times do # 10s timeout
          $vorax_if.read
          sleep 0.1
        end
      rescue PTY::ChildExited => msg
      end
      $vorax_if = nil
    end
EOF
  " no garbage please: delete the temporary file, if any
  if a:temp_file != ''
    call delete(a:temp_file)
  endif
endfunction

" Get the common interface object.
function Vorax_GetCommonInterface()
  return s:common_if
endfunction
