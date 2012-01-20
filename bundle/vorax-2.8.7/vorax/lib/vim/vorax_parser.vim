" Description: Parsing stuff for VoraX
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>
" License: Apache License 2.0

" no multiple loads allowed
if exists("s:vorax_parsing")
  finish
endif

" Mark as loaded
let s:vorax_parsing = 1

" Parser object reference
let s:parser = {}

" Get info about the modules from the cmd. It returns a list
" of dictionary entries with the following keys: 
"   owner => the owner of the plsql module... empty if no owner
"            was specified
"   object => the plsql module name
"   type => the type of the module (e.g. PACKAGE, PACKAGE BODY etc.)
"   start_line => the line where this module is defined in a:cmd
" These analisis are done using ANTLR3 and are gathered for displaying
" compilation errors and link to the right line within the buffer.
function s:parser.ModulesInfo(cmd) dict
  let info = []
  ruby << EOF
    input = ANTLR3::StringStream.new(VIM::evaluate('a:cmd').upcase)
    lexer = PlsqlBlock::Lexer.new(input)
    lexer.map 
    lexer.oracle_modules.each do |m|
      cmd = "call add(info, {'start_line':#{m[:start_line]}, 'owner' : '#{m[:owner]}', 'object' : '#{m[:object]}', 'type' : '#{m[:type]}', 'in_body' : '#{m[:in_body]}' })"
      VIM::command(cmd)
    end
EOF
  return info
endfunction

" Get info about the submodules(functions/procs) from the pkg. It returns a list
" of dictionary entries with the following keys: 
"   object => the plsql module name
"   type => the type of the module (e.g. PACKAGE, PACKAGE BODY etc.)
"   start_line => the line where this module is defined in a:cmd
" These analisis are done using ANTLR3 and are gathered for displaying
" compilation errors and link to the right line within the buffer.
function s:parser.SubmodulesInfo(pkg) dict
  let info = []
  ruby << EOF
    input = ANTLR3::StringStream.new(VIM::evaluate('a:pkg').upcase)
    lexer = Submodule::Lexer.new(input)
    lexer.map 
    lexer.oracle_submodules.each do |m|
      cmd = "call add(info, {'start_line':#{m[:start_line]}, 'object' : '#{m[:object]}', 'type' : '#{m[:type]}'})"
      VIM::command(cmd)
    end
EOF
  return info
endfunction


" Get the parser object
function Vorax_ParserToolkit()
  return s:parser
endfunction
