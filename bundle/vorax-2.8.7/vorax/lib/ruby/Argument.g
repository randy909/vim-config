lexer grammar Argument;

options {
  language=Ruby;
  filter=true;
}

@members {
  attr_reader :pmodules
  private
  ArgItem = Struct.new(:pos, :expr)
}

@init {
  @pmodules = []
  @open = false
  @stack = []
  @parent = -1
}

QUOTED_STRING
  : ( 'n' )? '\'' ( '\'\'' | ~('\'') )* '\''
  ;
  
SL_COMMENT
  : '--' ~('\n'|'\r')* '\r'? '\n' 
  ;
  
ML_COMMENT
  : '/*' ( options {greedy=false;} : . )* '*/' 
  ;

PLSQL_MODULE
  : (tk1=ID '.' tk2=ID '.' tk3=ID WS? p=START_PROC)
  { @pmodules << {:name => $tk1.text + '.' + $tk2.text + '.' + $tk3.text, :args => [ArgItem.new($p.start + 1 .. $p.stop + 1, nil)] } ; @parent += 1 }
  | (tk1=ID '.' tk2=ID WS? p=START_PROC)
  { @pmodules << {:name => $tk1.text + '.' + $tk2.text, :args => [ArgItem.new($p.start + 1 .. ($p.stop + 1), nil)] } ; @parent += 1 }
  | (ID WS? p=START_PROC)
  { @pmodules << {:name => $ID.text, :args => [ArgItem.new($p.start + 1 .. ($p.stop + 1), nil)] } ; @parent += 1}
  ;

fragment
START_PROC
  : '(' WS?
  ;

CEXPR
  : tk=EXPR { @pmodules[@parent][:args] << ArgItem.new($tk.start .. $tk.stop, $tk.text) if @parent >= 0 }
  ;

fragment
PARAM_DELIM
  : ',' WS?
  ;

fragment
EXPR
  : '(' ( EXPR | ~(')') )* ')' 
  ; 

START_ARGUMENT
  : p=PARAM_DELIM
  { @pmodules[@parent][:args] << ArgItem.new($p.start + 1 .. ($p.stop + 1), nil) if @parent >= 0 }
  ;

END_FUNC
  : ')' { @parent -= 1 if @parent > 0 }
  ;

WS  
  : (' '|'\t'|'\n')+
  ;

fragment
ID 
    : 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
    | DOUBLEQUOTED_STRING
    ;

fragment
DOUBLEQUOTED_STRING
  : '"' ( ~('"') )* '"'
  ;

