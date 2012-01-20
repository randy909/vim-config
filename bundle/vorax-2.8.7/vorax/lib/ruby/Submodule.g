lexer grammar Submodule;

options {
  language=Ruby;
  filter=true;
}

@members {

  attr_reader :oracle_submodules

  private

  def add_entry(tk, type)
    @object_name.gsub!(/\"/, '') if @object_name
    pos = tk.start
    lines = self.input.data[ 0 .. pos ]
    @oracle_submodules << { :object => @object_name, :type => type, :start_line => lines.split(/\n/).length }
    @object_name = nil
  end

}

@init {
  @oracle_submodules = []
}

SUBMODULE
  : WS tk=SUBMODULE_TYPE WS SUBMODULE_NAME
  {
    add_entry($tk, $tk.text)
  }
  ;

QUOTED_STRING
  : ( 'n' )? '\'' ( '\'\'' | ~('\'') )* '\''
  ;
  
SL_COMMENT
  : '--' ~('\n'|'\r')* '\r'? '\n' 
  ;
  
ML_COMMENT
  : '/*' ( options {greedy=false;} : . )* '*/' 
  ;

fragment
WS  
  : (' '|'\t'|'\n')+
  ;

fragment
SUBMODULE_NAME
  : object=ID { @object_name = $object.text if $object }
  ;

fragment
SUBMODULE_TYPE
  : 'PROCEDURE'
  | 'FUNCTION'
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
