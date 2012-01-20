lexer grammar Alias;

options {
  language=Ruby;
  filter=true;
}

@members {

  @@level = 0
 
  attr_accessor :aliases, :cpos

  def self.gather_for(text, position=nil)
    input = ANTLR3::StringStream.new(text.upcase)
    lexer = Alias::Lexer.new(input)
    lexer.cpos = position
    lexer.map
    lexer.aliases
  end

  private

  AliasItem = Struct.new(:idn, :object, :owner, :dblink, :expr, :level)

  KEYS = [ 'ON', 'WHERE', 'FROM', 'CONNECT', 'START', 'GROUP', 'HAVING', 'MODEL' ]

  def add_alias(idn, object, owner=nil, dblink=nil, expr=false)
    @expr = false unless expr
    @aliases << AliasItem.new(idn, object, owner, dblink, expr, @@level) 
    @last_table = nil;
    @last_owner = nil;
    @last_dblink = nil;
    @last_alias = nil;
  end

  def next_word
    i = self.input.index - 1
    result = ''
    while prev_char = self.input.data[i..i]
      i -= 1
      break if prev_char !~ /[A-Z0-9$#_]/
      result += prev_char + result
    end
    i = 1
    while next_char = self.input.look(i)
      i += 1
      break if next_char !~ /[A-Z0-9$#_]/
      result += next_char
    end
    result
  end

}

@init {
  @aliases = []
  @last_table = nil;
  @last_owner = nil;
  @last_dblink = nil;
  @last_alias = nil;
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

FROM
  : 'FROM' WS TABLE_REFERENCE (WS? ',' WS? TABLE_REFERENCE)*
  ;

INTO
  : 'INTO' WS TABLE_REFERENCE (WS? ',' WS? TABLE_REFERENCE)*
  ;

UPDATE
  : 'UPDATE' WS TABLE_REFERENCE (WS? ',' WS? TABLE_REFERENCE)*
  ;

JOIN_CLAUSE
  : 'JOIN' WS TABLE_REFERENCE WS?
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

LBR
  : '(' { @@level += 1 }
  ;

RBR
  : ')' { @@level -= 1 }
  ;

fragment
SUB_SELECT
  : '(' ( SUB_SELECT | ~(')') )* ')'
  ; 

fragment
OBJ_ALIAS
  : { (KEYS.find { |key| next_word() == key }).nil? }? ID
  {
    @last_alias = $ID.text
  }
  ;

fragment
PLAIN_TABLE_REF 
  : (owner=ID '.')? table=ID ('@' dblink=ID)? {
    @last_table = $table ? $table.text : ''
    @last_owner = $owner ? $owner.text : ''
    @last_dblink = $dblink ? $dblink.text : ''
  }
  ;

fragment
TABLE_REFERENCE_WITH_ALIAS
  : PLAIN_TABLE_REF WS OBJ_ALIAS
  ;

fragment
TABLE_REFERENCE
  : (ss=SUB_SELECT WS? OBJ_ALIAS?)
    {
      if @last_alias
        add_alias(@last_alias, $ss.text, nil, nil, true)
      else
        add_alias(nil, $ss.text, nil, nil, true)
      end
      text = $ss.text
      @aliases += Alias::Lexer.gather_for(text,0)
      @input.consume
    }
    |
    (TABLE_REFERENCE_WITH_ALIAS WS?)
    {
      add_alias(@last_alias, @last_table, @last_owner, @last_dblink)
    }
    |
    (PLAIN_TABLE_REF WS?)
    {
      add_alias(nil, @last_table, @last_owner, @last_dblink)
    }
  ;
