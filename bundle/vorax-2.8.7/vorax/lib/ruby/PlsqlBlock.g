lexer grammar PlsqlBlock;

options {
  language=Ruby;
  filter=true;
}

@members {

  attr_reader :oracle_modules

  private

  def add_entry(tk, type)
    if type == 'PACKAGE BODY'
      @in_body = true
    elsif type == 'PACKAGE'
      @in_body = false
    end
    @object_name.gsub!(/"/, '') if @object_name
    @owner.gsub!(/"/, '') if @owner
    pos = tk.start
    lines = self.input.data[ 0 .. pos ]
    @oracle_modules << { :object => @object_name, :type => type, :owner => @owner, :start_line => lines.split(/\n/).length, :in_body => @in_body }
    @object_name = nil
    @object_type = nil
    @owner = nil
  end

}

@init {
  @oracle_modules = []
  @in_body = false
}

START_MODULE
  : tk='CREATE' (WS 'OR' WS 'REPLACE')? WS OBJECT_TYPE { @object_type = $OBJECT_TYPE.text if $OBJECT_TYPE} OBJECT
  {
    @object_type.strip! if @object_type
    if @object_type == 'PACKAGE BODY'
      @in_body = true
    end
    add_entry($tk, @object_type) if @object_type
  }
  ;

fragment
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
OBJECT
  : (owner=ID { @owner = $owner.text if $owner } '.')? object=ID { @object_name = $object.text if $object }
  ;

fragment
SUBMODULE_NAME
  : object=ID { @object_name = $object.text if $object }
  ;

fragment
OBJECT_TYPE
  : 'PROCEDURE' WS
  | 'FUNCTION' WS
  | 'TRIGGER' WS
  | 'TYPE' WS ('BODY' WS)? 
  | 'PACKAGE' WS ('BODY' WS)?
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
