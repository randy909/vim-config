" Description: Database layer abstraction for VoraX
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_dblayer")
  finish
endif

" mark this as loaded
let s:vorax_dblayer = 1

runtime! vorax/lib/vim/vorax_utils.vim
runtime! vorax/lib/vim/vorax_parser.vim

let s:interface = Vorax_GetInterface()
let s:tk_utils = Vorax_UtilsToolkit()
let s:tk_parser = Vorax_ParserToolkit()
let s:pwd_repo = substitute(fnamemodify(expand('$HOME'), ':p:8') . '/_vorax_passwords', '\\', '/', 'g')
let s:private_key_file = substitute(fnamemodify(expand('$HOME'), ':p:8') . '/vorax_key', '\\', '/', 'g')
let s:public_key_file = substitute(fnamemodify(expand('$HOME'), ':p:8') . '/vorax_key.pub', '\\', '/', 'g')

" Enable logging
if g:vorax_debug
  silent! call log#init('ALL', ['~/vorax.log'])
  silent! let s:log = log#getLogger(expand('<sfile>:t'))
endif

" The object reference
let s:db = { 'cdata': {}, 'connected': 0 }

" A temporary file to save to/restore from sqlplus settings
let s:fset = substitute(fnamemodify(tempname(), ':p:h:8'), '\\', '/', 'g') . '/vrx_settings.sql'

" ====== PUBLIC INTERFACE ====== 

" Get the database layer object
function Vorax_DbLayerToolkit()
  return s:db
endfunction

" Connects to the provided database using the cstr
" connection string. The cstr has the common sqlplus
" format user/password@db [as sys(dba|asm|oper). It also
" accepts incomplete formats like user@db or just user, the
" user being prompted afterwards for the missing parts.
function s:db.Connect(cstr) dict
  silent! call s:log.trace('start of s:db.Connect(cstr)')
  silent! call s:log.debug('cstr='.cstr)
  let result = []
  let all_cmd = ""
  let self.cdata = s:PromptCredentials(a:cstr)
  silent! call s:log.debug('cdata='.string(cdata))
  let connect_cmd = self.cdata['user'] . '/' . self.cdata['passwd']
  let profile = self.cdata['user']
  if self.cdata['osauth']
    let connect_cmd .= " " . self.cdata['db']
    let profile .= " " .self.cdata['db']
  else
    let connect_cmd .= "@" . self.cdata['db']
    let profile .= "@" .self.cdata['db']
  endif
  redraw
  let status = s:tk_utils.Translate(g:vorax_messages['connecting'], profile)
  let connect_cmd = 'connect ' . connect_cmd
  call s:interface.startup()
  if s:interface.last_error == ""
    silent! call s:log.debug('interface successfully started.')
    " defines the _O_VERSION sqlplus variable. this is needed
    " because in case the autentication fails this variable
    " will not be automatically defined and we'll be prompted
    " for its value when we are about to show it after the
    " connect attempt.
    let all_cmd .= "define _O_VERSION='not connected.'\n"
    " add the actual connect statement
    let all_cmd .= connect_cmd . "\n"
    " show information about the target database to which the user
    " is connected to
    let all_cmd .= "prompt &_O_VERSION\n"
    let all_cmd .= "prompt \n"
    let all_cmd .= "prompt \n"
    " add commands to initialize/set the sqlplus environment.
    let cmds = split(g:vorax_sqlplus_header, '\n')
    for cmd in cmds
      let all_cmd .= cmd . "\n"
    endfor
    " save current sqlplus settings and prepare sqlplus for a silent exec
    let save_cmd = 'store set ' . s:interface.convert_path(s:fset) . " replace\n" .
          \  "set echo off\n" .
          \  "set feedback off\n" .
          \  "set autotrace off\n" .
          \  "set pagesize 9999\n" .
          \  "set heading off\n" .
          \  "set timing off\n" .
          \  "set linesize 200\n"
    silent! call s:log.debug('Execute: '. save_cmd)
    call s:interface.send(s:interface.pack(save_cmd))
    if s:interface.last_error == ""
      " if no errors then consume the output
      let output = self.ReadAll(status)
      silent! call s:log.debug('Output: '. string(output))
      " send the command to the interface
      silent! call s:log.debug('Execute: '. all_cmd)
      call s:interface.send(s:interface.pack(all_cmd))
      call s:interface.mark_end()
      " mark as disconnected
      let &titlestring = ""
      let self.connected = 0
      if s:interface.last_error == ""
        " if no errors then read the output
        let result = self.ReadAll(status)
        silent! call s:log.debug('Output: '. string(result))
        " restore the previous saved settings
        silent! call s:log.debug('Restore sqlplus settings by running: @' . s:interface.convert_path(s:fset))
        call s:interface.send('@' . s:interface.convert_path(s:fset))
        " execute header
        silent! call s:log.debug('About to execute header.')
        let all_cmd = ""
        let cmds = split(g:vorax_sqlplus_header, '\n')
        for cmd in cmds
          let all_cmd .= cmd . "\n"
        endfor
        silent! call s:log.debug(all_cmd)
        call s:interface.send(s:interface.pack(all_cmd))
        if s:interface.last_error == ""
          " if no errors then consume the output
          let output = self.ReadAll(status)
          silent! call s:log.debug('Output: '. string(output))
          " check the connection
          if g:vorax_update_title
            let title = self.ConnectionOwner()
            if title =~ '^[^@]\+@[^@]\+$'
              let &titlestring = title
              let self.connected = 1
            endif
          else
          	let connectedTo = '/'
            " we don't know but assume it's connected
            let self.connected = 1
          endif
        endif
      endif
    endif
  endif
  if s:interface.last_error != ""
    silent! call s:log.error(s:interface.last_error)
    let self.connected = 0
    let &titlestring = "not connected"
    throw 'VRX-CONNECT: ' . s:interface.last_error
  endif
  " rebuild the dbexplorer
  call Vorax_RebuildDbExplorer()
  if g:vorax_store_passwords 
  	if self.connected
      " if connected succesfull then save pasword
      call s:StorePassword(profile, self.cdata['passwd'])
    else
    	" is it a ORA-01017 error?
    	if join(result, ' ') =~ 'ORA-01017' 
    		if s:ProfileInRepo(profile, s:pwd_repo)
          " the password has changed; remove the old entry
          echo g:vorax_messages['stale_pwd']
          call s:DeleteProfileFromRepo(profile, s:pwd_repo)
          let connect_cmd = self.cdata['user'] 
          let profile = self.cdata['user']
          if self.cdata['osauth']
            let connect_cmd .= " " . self.cdata['db']
            let profile .= " " .self.cdata['db']
          else
            let connect_cmd .= "@" . self.cdata['db']
            let profile .= "@" .self.cdata['db']
          endif
          let result = self.Connect(connect_cmd)
        endif
      endif
    endif
  endif
  silent! call s:log.trace('end of s:db.Connect(cstr). Returned value: '. string(result))
  return result
endfunction

" read all output from the interface
function s:db.ReadAll(feedback) dict
  let result = []
  let truncated = 1
  if s:interface.more
    " collect results
    while 1
      let buffer = s:interface.read()
      if len(buffer) > 0 
        silent! call s:log.debug('read all buffer='. string(buffer))
        if s:interface.last_error != ""
          " an error has occured... do not continue
          silent! call s:log.error(s:interface.last_error)
          throw 'VRX-READ: ' . s:interface.last_error
        endif
        if truncated && len(result) > 0
          let result[-1] = result[-1] . buffer[0]
          call remove(buffer, 0)
        endif
        call extend(result, buffer)
        let truncated = s:interface.truncated
      else
        if !s:interface.more
          break
        endif
      endif
      " show progress informationn... a redraw is needed
      if a:feedback != ""
        redraw
        echon a:feedback . " " . s:tk_utils.BusyIndicator()
      endif
      sleep 10m
    endwhile
  endif
  if a:feedback != ""
    " clear feedback message
    redraw
    echon ''
  endif
  return result
endfunction

" Get the end delimitator. This function tries to guess the
" type of the delimitator according to the given statement. If
" a plsql block is given then a slash is returned otherwise, if
" no ';' is detected then ';' is returned.
function s:db.Delimitator(cmd) dict
  silent! call s:log.trace('s:db.Delimitator(cmd)')
  silent! call s:log.debug('cmd='.string(cmd))
  if a:cmd =~ '\v\n+\s*/\s*\n*$'
    " if an ending slash is found then no delimitator is required
    silent! call s:log.trace('An ending slash was found. No delimitator is returned.')
    return ''
  endif
  if a:cmd =~? '\v\_s+end\_s*;\_s*\_$'
    " a plsql block was given
    silent! call s:log.trace('A plsql block was found. Return a slash.')
    return "\n/\n"
  elseif a:cmd !~ '\v\_s*;\_s*\_$'
    " a regular sqlplus command. Pay attention that no \n is
    " added in order to cover the sqlplus special commands too.
    " For example, if the command is 'set lines 200' we detect
    " that there's no terminator therefore we add one, but on
    " the same line. It would be wrong in this case to add this
    " terminator on a new line.
    silent! call s:log.trace('A regular sql/sqlplus statement was found. Return ;')
    return ';'
  else
    silent! call s:log.trace('No delimitator is needed.')
    return ''
  endif
endfunction

" Save the current options set for sqlplus environment
function s:db.SaveSqlplusState() dict
  call s:interface.send('store set ' . s:interface.convert_path(s:fset) . " replace\n")
  " consume the output
  call s:interface.mark_end()
  if s:interface.last_error == ""
    " if no errors then consume the output
    call self.ReadAll('')
  endif
endfunction

" Restore a previous saved sqlplus state
function s:db.RestoreSqlplusState() dict
  call s:interface.send('@' . s:interface.convert_path(s:fset))
endfunction

" This function is used to silently execute a command.
function s:db.Exec(cmd, feedback) dict
  silent! call s:log.trace('start of s:db.Exec(cmd)')
  silent! call s:log.debug('cmd='.a:cmd)
  let result = []
  " save current sqlplus settings and prepare sqlplus for a silent exec
  call self.SaveSqlplusState()
  call s:interface.send(s:interface.pack("set echo off\n" .
        \  "set feedback off\n" .
        \  "set autotrace off\n" .
        \  "set pagesize 9999\n" .
        \  "set heading off\n" .
        \  "set linesize 10000\n" .
        \  "set verify off\n" .
        \  "set termout on\n" .
        \  "set timing off\n" .
        \  "set array 500\n" .
        \  "set emb on pages 0 newp none\n"))
  if s:interface.last_error == ""
    try
      " if no errors then consume the output
      call self.ReadAll(a:feedback)
      " send the command to the interface
      call s:interface.send(s:interface.pack(a:cmd))
      if s:interface.last_error == ""
        " if no errors then read the output
        let result = self.ReadAll(a:feedback)
        " restore the previous saved settings
        call self.RestoreSqlplusState()
        call s:interface.mark_end()
        if s:interface.last_error == ""
          " if no errors then consume the output
          call self.ReadAll('')
        endif
      endif
    catch /^VRX-READ/
      silent! call s:log.error(v:exception)
      s:tk_utils.EchoErr(v:exception)
    endtry
  endif
  " clear status
  if a:feedback != ""
    redraw
    echon " "
  endif
  silent! call s:log.trace('end of s:db.Exec(cmd)')
  return result
endfunction

" Get the user@db for the current connection.
function s:db.ConnectionOwner() dict
  silent! call s:log.trace('start of s:db:ConnectionOwner')
  call self.SaveSqlplusState()
  let cmd = "set define on\n" .
        \ "set termout on\n" .
        \ "set verify off\n" .
        \ "set echo off\n" .
        \ "set linesize 80\n" .
        \ "prompt &_USER@&_CONNECT_IDENTIFIER"
  let result = self.Exec(cmd, "")
  call self.RestoreSqlplusState()
  call s:interface.mark_end()
  if s:interface.last_error == ""
    " if no errors then consume the output
    call self.ReadAll('')
  endif
  " set the title
  if len(result) > 0
    silent! call s:log.trace('return: ' . result[0])
    return result[0]
  else
    " an error has occured
    silent! call s:log.error(s:interface.last_error)
    return ""
  endif
endfunction

" This function is used to resolve a object name within the database
" context. It returnes a dictionary with the following keys:
"   'schema' => the schema of the object
"   'object' => the actual object
"   'dblink' => the name of the dblink if any
"   'type'   => the type of the object:
"                 2  = tables
"                 4  = views
"                 5  = synonym
"                 7  = procedure
"                 8  = function
"                 9  = packages
"                 13 = types
function s:db.ResolveDbObject(object) dict
  silent! call s:log.trace('start of s:db:ResolveDbObject(object)')
  silent! call s:log.debug('object='.a:object)
  let result = self.Exec(
        \ "set serveroutput on\n" .
        \ "declare\n".
        \ "   type t_context is varray(3) of integer;\n" .
        \ "   schema varchar2(30);\n" .
        \ "   part1 varchar2(30);\n" .
        \ "   part2 varchar2(30);\n" .
        \ "   dblink varchar2(100);\n" .
        \ "   part1_type number;\n" .
        \ "   object_number number;\n" .
        \ "   l_obj varchar2(100);\n" .
        \ "   l_skip boolean := false;\n" .
        \ "   try_ctx t_context := t_context(1, 2, 7);\n" .
        \ "   invalid_context exception;\n" .
        \ "   no_object exception;\n" .
        \ "   pragma exception_init(invalid_context, -04047);\n" .
        \ "   pragma exception_init(no_object, -06564);\n" .
        \ " begin\n" .
        \ "   for ctx in try_ctx.first .. try_ctx.last loop\n" .
        \ "     begin\n" .
        \ "       DBMS_UTILITY.NAME_RESOLVE (\n" .
        \ "          '" . a:object . "', \n" .
        \ "          try_ctx(ctx),\n" .
        \ "          schema, \n" .
        \ "          part1, \n" .
        \ "          part2,\n" .
        \ "          dblink, \n" .
        \ "          part1_type, \n" .
        \ "          object_number);\n" .
        \ "       l_skip := false;\n" .
        \ "     exception\n" .
        \ "       when invalid_context then\n" .
        \ "         l_skip := true;\n" .
        \ "       when no_object then\n" .
        \ "         return;\n" .
        \ "     end;\n" .
        \ "     if l_skip = false then\n" .
        \ "       if part1 is not null then\n" .
        \ "          l_obj := part1;\n" .
        \ "       elsif part1 is null and part2 is not null then\n" .
        \ "          l_obj := part2;\n" .
        \ "       end if;\n" .
        \ "       dbms_output.put_line(schema || '::' || l_obj || '::' || dblink || '::' || part1_type);\n" .
        \ "       return;\n" .
        \ "     end if;\n" .
        \ "   end loop;\n" .
        \ " end;\n" .
        \ "/\n"
        \ , "" )
  let info = {}
  if len(result) > 0
    " we have results
    let record = result[0]
    let fields = split(record, '::')
    if len(fields) == 4
      let info['schema'] = fields[0]
      let info['object'] = fields[1]
      let info['dblink'] = fields[2]
      let info['type'] = fields[3]
    endif
  endif
  silent! call s:log.trace('end of s:db:ResolveDbObject(object). returned value='.string(info))
  return info
endfunction

" Get the source for the provided proc/func/package
function s:db.GetSource(type, object_name, schema) dict
  silent! call s:log.trace('start of s:db:GetSource(type, object_name, schame)')
  silent! call s:log.debug('type='.a:type.' object_name='.a:object_name.' schema='.a:schema)
  let type = a:type
  let object_name = a:object_name
  let result = []
  let result = self.Exec("set long 1000000000 longc 60000\n" .
        \ "set wrap on\n" .
        \ "exec dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', TRUE );\n" .
        \ "exec dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'BODY', TRUE );\n" .
        \ "select dbms_metadata.get_ddl('" . type . "', '" . object_name . "', " . a:schema . ") from dual;"
        \ , "Loading source...")
  " remove empty lines from the begin/end
  let result = s:TrimResult(result)
  return result
  silent! call s:log.trace('end of s:db:GetSource(type, object_name, schame)')
endfunction

" Convert the numeric type return by the vorax#resolveDbObject to the textual
" database type representation.
function s:db.DbType(type) dict
  if a:type == 2
    return 'TABLE'
  elseif a:type == 4
    return 'VIEW'
  elseif a:type == 5
    return 'SYNONYM'
  elseif a:type == 7
    return 'PROCEDURE'
  elseif a:type == 8
    return 'FUNCTION'
  elseif a:type == 9
    return 'PACKAGE'
  elseif a:type == 13
    return 'TYPE'
  endif
endfunction

" Opens for editing the provided database object.
function s:db.LocateDbObject(object) dict
  let info = self.ResolveDbObject(a:object)
  let parts = split(a:object, '\.')
  if has_key(info, 'schema')
    redraw
    echon s:tk_utils.Translate(g:vorax_messages['open_obj'], a:object)
    let type = self.DbType(info.type)
    let fname = substitute(fnamemodify(tempname(), ':h:p:8'), '\\', '/', 'g') . '/_view_' . info.object . '.' . s:tk_utils.ExtensionForType(type)
    call s:tk_utils.FocusCandidateWindow()
    silent! exe 'edit ' . fname
    " an already existing buffer in read only mode may be opened
    setlocal modifiable
    call vorax#InitBuffer()
    " clear buffer
    normal ggdG
    " get source
    let result = self.GetSource(type, info.object, "'" . info.schema . "'")
    call append(0, result)
    " delete the leading blanks from the first line... the dbms_metadata.getddl
    " puts some blanks before the CREATE statement
    :1s/^\s*//
    " clear the previous highlight
    :nohlsearch
    :w!
    if info.type == 9
      " this is a package
      let submodule = substitute(parts[-1], '"', '', 'g')
      if  submodule !=? info.object
        redraw
        echo s:tk_utils.Translate(g:vorax_messages['search_for'], submodule) 
        call s:LocateSubmodule(submodule, join(result, "\n"))
      endif
    else
      " go to the start of the buffer
      normal gg
    endif
    " set the buffer as read only
    setlocal nomodifiable
  endif
  redraw
  echo g:vorax_messages['done']
endfunction

" ====== PRIVATE FUNCTIONS ====== 

function s:LocateSubmodule(submodule, source)
  let submodule = substitute(a:submodule, '"', '', 'g')
  let pkg_info = s:tk_parser.SubmodulesInfo(a:source)
  for data in pkg_info
    if data.object ==? a:submodule
      silent exe 'normal ' . data.start_line . 'G'
      " don't break because we want the last definition to be showed
    endif
  endfor
endfunction

" Trim all empty lines from the start/end of the
" provided result
function s:TrimResult(result)
  let result = a:result
  let idx = 0
  for line in result
    if line == ""
      let idx += 1
    else
      break
    endif
  endfor
  if idx > 0
    call remove(result, 0, idx - 1)
  endif
  " remove empty lines from the end
  while len(result) > 0 
    if result[len(result) - 1] == ""
      call remove(result, len(result) - 1)
    else
      break
    endif
  endwhile
  return result
endfunction

" This function is used to parse a connect string. It receives
" a string like 'user/pwd@db' and it breaks it down into the
" corresponding user,pwd,db parts. It returns these components
" into a dictionary structure: 
"   {'user': , 'passwd': , 'db': , 'osauth': }
" The osauth flag is set if the provided connection string is 
" requesting an OS authentication (e.g. / as sysdba).
function s:ParseCstr(cstr) 
  " parse the connect string
  let conn_str = a:cstr
  let cdata = {'user': '', 'passwd': '', 'db': '', 'osauth' : 0}
  " find the position of the first unquoted @
  let arond_pos = match(conn_str, '@\([^\"]*"\([^"]\|"[^"]*"\)*$\)\@!', 1, 1)
  " find the position of the first unquoted /
  let slash_pos = match(conn_str, '\/\([^\"]*"\([^"]\|"[^"]*"\)*$\)\@!', 1, 1)
  if arond_pos >= 0
    " we have the database specified
    let cdata['db'] = toupper(strpart(conn_str, arond_pos + 1, strlen(conn_str)))
    let conn_str = strpart(conn_str, 0, arond_pos)
  endif
  if slash_pos >= 0
    " we have the username and the password specified
    let cdata['user'] = strpart(conn_str, 0, slash_pos)
    let cdata['passwd'] = strpart(conn_str, slash_pos + 1, strlen(conn_str))
  else
    " if no slash then everything before @ is asumed to be the user
    let cdata['user'] = conn_str
  endif
  " trim leading/trailing spaces from cdata
  for key in keys(cdata)
    let cdata[key] = substitute(cdata[key],'^\s\+\|\s\+$',"","g")
  endfor
  " check for OS auth
  if cdata['db'] == '' || cdata['db'] =~? '^\s*as\s*(sysdba|sysasm|sysoper)\s*$'
    let cdata['osauth'] = 1
  endif
  return cdata
endfunction

" Prompt the user for the credentials. It requests only the missing parts
" therefore if you already provided something like user@db then just
" the password will be requested. It returns a dictionary similar with
" s:ParseCstr() function.
function s:PromptCredentials(cstr)
  let cdata = s:ParseCstr(a:cstr)
  if cdata['user'] == ''
    " prompt for user
    let user = input(g:vorax_messages['username'] . ': ')
    if (cdata['passwd'] == '') || (cdata['db'] == '')
      " reparse the new provided string
      let ncd = s:ParseCstr(user)
      let cdata['osauth'] = ncd['osauth']
      let cdata['user'] = ncd['user']
      if ncd['passwd'] != ''
        let cdata['passwd'] = ncd['passwd']
      endif
      if ncd['db'] != ''
        let cdata['db'] = ncd['db']
      endif
    endif
  endif
  if cdata['passwd'] == ''
    let passwd = ""
    if g:vorax_store_passwords && cdata['db'] != ''
      " search for a password into repository
      let profile = cdata['user'] . '@' . cdata['db']
      let passwd = s:GetPassword(profile)
    endif
    if passwd == ""
      let cdata['passwd'] = inputsecret(g:vorax_messages['password'] . ': ')
    else
      let cdata['passwd'] = passwd
    endif
  endif
  return cdata
endfunction

" This function is used to get the corresponding password for the provided provile.
" The password is fetched from vorax secure password repository.
function s:GetPassword(profile)
  if s:ProfileInRepo(a:profile, s:pwd_repo) && !s:ProfileSkip(a:profile, s:pwd_repo)
    let info = {'error' : "", 'pwd' : ""}
    " look for the private key
    if !filereadable(s:private_key_file)
      " the repository is not yet initialized
      return ""
    else
      let error = ""
      for i in range(3)
        if !exists('s:master_password') || error != ""
          let s:master_password = inputsecret(g:vorax_messages['master_password'] . ': ')
        endif
        let info = s:GetPwdFromRepo(a:profile, s:pwd_repo, s:private_key_file, s:public_key_file)
        let error = info.error
        if error != ''
          redraw
          call s:tk_utils.EchoErr(g:vorax_messages['invalid_password'] . "\n" . error)
        else
          break
        endif
      endfor
      if error != ''
        unlet s:master_password
        redraw
        call s:tk_utils.EchoErr(g:vorax_messages['passwd_retry_exceeded'])
      endif
      return info.pwd
    endif
  endif
  return ""
endfunction

" This is a low level function which is used to get the password for a provided
" profile, using a given: repository, private key file and public key file. It
" returns a dictionary with two keys: 'pwd' => the actual password, 'error' =>
" a specific error if any.
function s:GetPwdFromRepo(profile, pwd_repo, private_key_file, public_key_file)
  let error = ""
  let password = ""
  ruby << EOF
    begin
      pwd_repo = Vorax::PasswordRepository.new(VIM::evaluate('a:pwd_repo'), 
                                               VIM::evaluate('a:private_key_file'), 
                                               VIM::evaluate('a:public_key_file'), 
                                               VIM::evaluate('s:master_password'))
      VIM::command("let password='" + pwd_repo.get_password(VIM::evaluate('a:profile').gsub(/'/, "''")) + "'")
    rescue => ex
      VIM::command("let error = '" + ex.message + "'")
    end
EOF
  return {'error' : error, 'pwd' : password}
endfunction

" This is a low level function which is used to write a password for a given profile
" into the VoraX secure passwd repository. The repository file location, the private
" key file and the public key file must be also provided. It returns the error message if
" this function fails or an empty string for success.
function s:WriteToPwdRepo(profile, password, pwd_repo, private_key_file, public_key_file)
  let error = ""
  let master_pwd = exists('s:master_password') ? s:master_password : ""
  ruby << EOF
    begin
      pwd_repo = Vorax::PasswordRepository.new(VIM::evaluate('a:pwd_repo'), VIM::evaluate('a:private_key_file'), VIM::evaluate('a:public_key_file'), VIM::evaluate('master_pwd'))
      pwd_repo.add_password(VIM::evaluate('a:profile'), VIM::evaluate('a:password'))
    rescue => ex
      VIM::command("let error = '" + ex.message + "'")
    end
EOF
  return error
endfunction

" This is a low level function used to generate the private key file and the public key
" when the Vorax password repository is going to be created.
function s:GenerateRsaKeys(private_key_file, public_key_file)
  let error = ""
  ruby << EOF
    # generate keys
    begin
      Vorax::PasswordRepository.generate_keys(VIM::evaluate('a:private_key_file'), VIM::evaluate('a:public_key_file'), VIM::evaluate('s:master_password'))
    rescue => ex
      VIM::command("let error = '" + ex.message + "'")
    end
EOF
  return error
endfunction

" Returns if 1 if the provided profile is in the repository or not
function s:ProfileInRepo(profile, pwd_repo)
  let status = 0
  ruby << EOF
    begin
      pwd_repo = Vorax::PasswordRepository.new(VIM::evaluate('a:pwd_repo'), nil, nil, nil)
      VIM::command('let status = 1') if pwd_repo.exists?(VIM::evaluate('a:profile'))
    rescue => ex
      # ignore errors
    end
EOF
  return status
endfunction

" Delete the provided profile from the pwd_repo repository
function s:DeleteProfileFromRepo(profile, pwd_repo)
  ruby << EOF
    pwd_repo = Vorax::PasswordRepository.new(VIM::evaluate('a:pwd_repo'), nil, nil, nil)
    pwd_repo.remove_profile(VIM::evaluate('a:profile'))
EOF
endfunction

" Returns if 1 if the provided profile is in the repository but should be ignored
function s:ProfileSkip(profile, pwd_repo)
  let status = 0
  ruby << EOF
    begin
      pwd_repo = Vorax::PasswordRepository.new(VIM::evaluate('a:pwd_repo'), nil, nil, nil)
      VIM::command('let status = 1') if pwd_repo.skip?(VIM::evaluate('a:profile'))
    rescue => ex
      # ignore errors
    end
EOF
  return status
endfunction

" This function is used to store a password for a given profile. It is called from
" the connect function.
function s:StorePassword(profile, password)
    " pwd repository location
    let pwd = a:password
    " look for the private key
    if !filereadable(s:private_key_file)
      let user_response = input(g:vorax_messages['store_passwd_question'] . ' (Y/n): ')
      if user_response == "" || user_response ==? 'y'
        redraw
        echo g:vorax_messages['passwd_repo_not_ready']
        while 1
          let s:master_password = inputsecret(g:vorax_messages["master_passwd_required"] . ': ')
          let retype_master_password = inputsecret(g:vorax_messages['retype_master_passwd'] . ': ')
          if s:master_password != retype_master_password
            redraw
            call s:tk_utils.EchoErr(g:vorax_messages['passwd_mismatch'])
          else
            let error = s:GenerateRsaKeys(s:private_key_file, s:public_key_file)
            let error = s:WriteToPwdRepo(a:profile, pwd, s:pwd_repo, s:private_key_file, s:public_key_file)
            if error != ''
              redraw
              call s:tk_utils.EchoErr(error)
            endif
            break
          endif
        endwhile
      endif
    else
      let user_response = 'n'
      if !s:ProfileInRepo(a:profile, s:pwd_repo) && !s:ProfileSkip(a:profile, s:pwd_repo)
        let user_response = input(g:vorax_messages['store_passwd_question'] . ' ([Yes (Y)] / No (N) / Never (E)): ')
        if user_response ==? 'e'
          " if never we put an empty password and we store it
          let pwd = ""
          let error = s:WriteToPwdRepo(a:profile, pwd, s:pwd_repo, "", "")
          if error != ''
            redraw
            call s:tk_utils.EchoErr(g:vorax_messages["invalid_password"] . "\n" . error)
          endif
        endif
        if (user_response == "" || user_response ==? 'y') && pwd != ""
          let error = ""
          for i in range(3)
            if (!exists('s:master_password') || error != "")
              let s:master_password = inputsecret(g:vorax_messages['master_password'] . ': ')
            endif
            let error = s:WriteToPwdRepo(a:profile, pwd, s:pwd_repo, s:private_key_file, s:public_key_file)
            if error != ''
              redraw
              call s:tk_utils.EchoErr(g:vorax_messages["invalid_password"] . "\n" . error)
            else
              break
            endif
          endfor
          if error != ''
            unlet s:master_password
            redraw
            call s:tk_utils.EchoErr(g:vorax_messages['passwd_retry_exceeded'])
          endif
        endif
      endif
    endif
endfunction

