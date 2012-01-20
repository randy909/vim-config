#!/usr/bin/env ruby
#
# vorax\\lib\\ruby\\Plsql.g
# 
# Generated using ANTLR version: 3.2.1-SNAPSHOT Jun 18, 2010 05:38:11
# Ruby runtime library version: 1.7.4
# Input grammar file: vorax\\lib\\ruby\\Plsql.g
# Generated at: 2010-07-16 10:19:34
# 

# ~~~> start load path setup
this_directory = File.expand_path( File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( this_directory ) unless $LOAD_PATH.include?( this_directory )

antlr_load_failed = proc do
  load_path = $LOAD_PATH.map { |dir| '  - ' << dir }.join( $/ )
  raise LoadError, <<-END.strip!
  
Failed to load the ANTLR3 runtime library (version 1.7.4):

Ensure the library has been installed on your system and is available
on the load path. If rubygems is available on your system, this can
be done with the command:
  
  gem install antlr3

Current load path:
#{ load_path }

  END
end

defined?( ANTLR3 ) or begin
  
  # 1: try to load the ruby antlr3 runtime library from the system path
  require 'antlr3'
  
rescue LoadError
  
  # 2: try to load rubygems if it isn't already loaded
  defined?( Gem ) or begin
    require 'rubygems'
  rescue LoadError
    antlr_load_failed.call
  end
  
  # 3: try to activate the antlr3 gem
  begin
    Gem.activate( 'antlr3', '~> 1.7.4' )
  rescue Gem::LoadError
    antlr_load_failed.call
  end
  
  require 'antlr3'
  
end
# <~~~ end load path setup


module Plsql
  # TokenData defines all of the token type integer values
  # as constants, which will be included in all 
  # ANTLR-generated recognizers.
  const_defined?( :TokenData ) or TokenData = ANTLR3::TokenScheme.new

  module TokenData

    # define the token constants
    define_tokens( :BULK_ROWCOUNT_ATTR => 29, :EXPONENT => 32, :T__159 => 159, 
                    :T__158 => 158, :T__160 => 160, :DOUBLEDOT => 9, :FOUND_ATTR => 25, 
                    :T__167 => 167, :EOF => -1, :T__165 => 165, :T__166 => 166, 
                    :T__163 => 163, :T__164 => 164, :T__161 => 161, :T__162 => 162, 
                    :T__93 => 93, :T__94 => 94, :T__91 => 91, :RPAREN => 8, 
                    :QUOTE => 46, :T__92 => 92, :T__148 => 148, :T__90 => 90, 
                    :T__147 => 147, :T__149 => 149, :GEQ => 36, :EQ => 22, 
                    :T__154 => 154, :T__155 => 155, :T__156 => 156, :T__99 => 99, 
                    :T__157 => 157, :T__98 => 98, :T__150 => 150, :T__97 => 97, 
                    :T__151 => 151, :DIVIDE => 31, :T__96 => 96, :T__152 => 152, 
                    :T__95 => 95, :T__153 => 153, :RBRACK => 24, :T__139 => 139, 
                    :T__138 => 138, :T__137 => 137, :T__136 => 136, :T__80 => 80, 
                    :T__81 => 81, :T__82 => 82, :T__83 => 83, :N => 45, 
                    :NUMBER => 15, :AT_SIGN => 33, :ROWCOUNT_ATTR => 28, 
                    :DOUBLEVERTBAR => 30, :T__141 => 141, :T__85 => 85, 
                    :T__142 => 142, :T__84 => 84, :T__87 => 87, :T__140 => 140, 
                    :T__86 => 86, :PERCENTAGE => 43, :T__145 => 145, :T__89 => 89, 
                    :T__146 => 146, :T__88 => 88, :T__143 => 143, :T__144 => 144, 
                    :T__126 => 126, :T__125 => 125, :T__128 => 128, :T__127 => 127, 
                    :WS => 47, :T__71 => 71, :T__72 => 72, :T__129 => 129, 
                    :T__70 => 70, :SL_COMMENT => 48, :T__76 => 76, :T__75 => 75, 
                    :T__74 => 74, :T__130 => 130, :T__73 => 73, :T__131 => 131, 
                    :T__132 => 132, :T__79 => 79, :T__133 => 133, :T__134 => 134, 
                    :T__78 => 78, :ROWTYPE_ATTR => 20, :T__135 => 135, :T__77 => 77, 
                    :T__68 => 68, :T__69 => 69, :T__66 => 66, :T__67 => 67, 
                    :T__64 => 64, :LBRACK => 23, :T__65 => 65, :T__62 => 62, 
                    :T__63 => 63, :POINT => 42, :T__118 => 118, :T__119 => 119, 
                    :T__116 => 116, :T__117 => 117, :GTH => 35, :T__114 => 114, 
                    :T__115 => 115, :T__124 => 124, :T__123 => 123, :LLABEL => 10, 
                    :T__122 => 122, :T__121 => 121, :T__120 => 120, :T__61 => 61, 
                    :ID => 40, :T__60 => 60, :LPAREN => 7, :ASTERISK => 21, 
                    :TYPE_ATTR => 19, :RLABEL => 11, :T__55 => 55, :T__56 => 56, 
                    :ML_COMMENT => 49, :T__57 => 57, :T__58 => 58, :T__51 => 51, 
                    :T__52 => 52, :T__53 => 53, :T__54 => 54, :T__107 => 107, 
                    :T__108 => 108, :COMMA => 12, :T__109 => 109, :T__103 => 103, 
                    :T__59 => 59, :T__104 => 104, :T__105 => 105, :T__106 => 106, 
                    :T__111 => 111, :T__110 => 110, :T__113 => 113, :T__112 => 112, 
                    :PLUS => 13, :QUOTED_STRING => 16, :DOT => 5, :T__50 => 50, 
                    :ISOPEN_ATTR => 27, :NOTFOUND_ATTR => 26, :DOUBLEQUOTED_STRING => 41, 
                    :T__102 => 102, :T__101 => 101, :T__100 => 100, :MINUS => 14, 
                    :SEMI => 4, :NOT_EQ => 34, :VERTBAR => 44, :COLON => 17, 
                    :LTH => 37, :ASSIGN => 6, :ARROW => 39, :CHARSET_ATTR => 18, 
                    :LEQ => 38 )
    
  end


  class Lexer < ANTLR3::Lexer
    @grammar_home = Plsql
    include TokenData

    
    begin
      generated_using( "vorax\\lib\\ruby\\Plsql.g", "3.2.1-SNAPSHOT Jun 18, 2010 05:38:11", "1.7.4" )
    rescue NoMethodError => error
      # ignore
    end
    
    RULE_NAMES   = [ "T__50", "T__51", "T__52", "T__53", "T__54", "T__55", 
                      "T__56", "T__57", "T__58", "T__59", "T__60", "T__61", 
                      "T__62", "T__63", "T__64", "T__65", "T__66", "T__67", 
                      "T__68", "T__69", "T__70", "T__71", "T__72", "T__73", 
                      "T__74", "T__75", "T__76", "T__77", "T__78", "T__79", 
                      "T__80", "T__81", "T__82", "T__83", "T__84", "T__85", 
                      "T__86", "T__87", "T__88", "T__89", "T__90", "T__91", 
                      "T__92", "T__93", "T__94", "T__95", "T__96", "T__97", 
                      "T__98", "T__99", "T__100", "T__101", "T__102", "T__103", 
                      "T__104", "T__105", "T__106", "T__107", "T__108", 
                      "T__109", "T__110", "T__111", "T__112", "T__113", 
                      "T__114", "T__115", "T__116", "T__117", "T__118", 
                      "T__119", "T__120", "T__121", "T__122", "T__123", 
                      "T__124", "T__125", "T__126", "T__127", "T__128", 
                      "T__129", "T__130", "T__131", "T__132", "T__133", 
                      "T__134", "T__135", "T__136", "T__137", "T__138", 
                      "T__139", "T__140", "T__141", "T__142", "T__143", 
                      "T__144", "T__145", "T__146", "T__147", "T__148", 
                      "T__149", "T__150", "T__151", "T__152", "T__153", 
                      "T__154", "T__155", "T__156", "T__157", "T__158", 
                      "T__159", "T__160", "T__161", "T__162", "T__163", 
                      "T__164", "T__165", "T__166", "T__167", "QUOTED_STRING", 
                      "ID", "SEMI", "COLON", "DOUBLEDOT", "DOT", "POINT", 
                      "COMMA", "EXPONENT", "ASTERISK", "AT_SIGN", "RPAREN", 
                      "LPAREN", "RBRACK", "LBRACK", "PLUS", "MINUS", "DIVIDE", 
                      "EQ", "PERCENTAGE", "LLABEL", "RLABEL", "ASSIGN", 
                      "ARROW", "VERTBAR", "DOUBLEVERTBAR", "NOT_EQ", "LTH", 
                      "LEQ", "GTH", "GEQ", "NUMBER", "N", "QUOTE", "DOUBLEQUOTED_STRING", 
                      "WS", "SL_COMMENT", "ML_COMMENT", "TYPE_ATTR", "ROWTYPE_ATTR", 
                      "NOTFOUND_ATTR", "FOUND_ATTR", "ISOPEN_ATTR", "ROWCOUNT_ATTR", 
                      "BULK_ROWCOUNT_ATTR", "CHARSET_ATTR", "Tokens" ].freeze
    RULE_METHODS = [ :t__50!, :t__51!, :t__52!, :t__53!, :t__54!, :t__55!, 
                      :t__56!, :t__57!, :t__58!, :t__59!, :t__60!, :t__61!, 
                      :t__62!, :t__63!, :t__64!, :t__65!, :t__66!, :t__67!, 
                      :t__68!, :t__69!, :t__70!, :t__71!, :t__72!, :t__73!, 
                      :t__74!, :t__75!, :t__76!, :t__77!, :t__78!, :t__79!, 
                      :t__80!, :t__81!, :t__82!, :t__83!, :t__84!, :t__85!, 
                      :t__86!, :t__87!, :t__88!, :t__89!, :t__90!, :t__91!, 
                      :t__92!, :t__93!, :t__94!, :t__95!, :t__96!, :t__97!, 
                      :t__98!, :t__99!, :t__100!, :t__101!, :t__102!, :t__103!, 
                      :t__104!, :t__105!, :t__106!, :t__107!, :t__108!, 
                      :t__109!, :t__110!, :t__111!, :t__112!, :t__113!, 
                      :t__114!, :t__115!, :t__116!, :t__117!, :t__118!, 
                      :t__119!, :t__120!, :t__121!, :t__122!, :t__123!, 
                      :t__124!, :t__125!, :t__126!, :t__127!, :t__128!, 
                      :t__129!, :t__130!, :t__131!, :t__132!, :t__133!, 
                      :t__134!, :t__135!, :t__136!, :t__137!, :t__138!, 
                      :t__139!, :t__140!, :t__141!, :t__142!, :t__143!, 
                      :t__144!, :t__145!, :t__146!, :t__147!, :t__148!, 
                      :t__149!, :t__150!, :t__151!, :t__152!, :t__153!, 
                      :t__154!, :t__155!, :t__156!, :t__157!, :t__158!, 
                      :t__159!, :t__160!, :t__161!, :t__162!, :t__163!, 
                      :t__164!, :t__165!, :t__166!, :t__167!, :quoted_string!, 
                      :id!, :semi!, :colon!, :doubledot!, :dot!, :point!, 
                      :comma!, :exponent!, :asterisk!, :at_sign!, :rparen!, 
                      :lparen!, :rbrack!, :lbrack!, :plus!, :minus!, :divide!, 
                      :eq!, :percentage!, :llabel!, :rlabel!, :assign!, 
                      :arrow!, :vertbar!, :doublevertbar!, :not_eq!, :lth!, 
                      :leq!, :gth!, :geq!, :number!, :n!, :quote!, :doublequoted_string!, 
                      :ws!, :sl_comment!, :ml_comment!, :type_attr!, :rowtype_attr!, 
                      :notfound_attr!, :found_attr!, :isopen_attr!, :rowcount_attr!, 
                      :bulk_rowcount_attr!, :charset_attr!, :token! ].freeze

    
    def initialize( input=nil, options = {} )
      super( input, options )

    end
    
    
    # - - - - - - - - - - - lexer rules - - - - - - - - - - - -
    # lexer rule t__50! (T__50)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__50!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 1 )

      type = T__50
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 7:9: 'CREATE'
      match( "CREATE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 1 )

    end

    # lexer rule t__51! (T__51)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__51!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 2 )

      type = T__51
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 8:9: 'OR'
      match( "OR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 2 )

    end

    # lexer rule t__52! (T__52)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__52!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 3 )

      type = T__52
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 9:9: 'IS'
      match( "IS" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 3 )

    end

    # lexer rule t__53! (T__53)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__53!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 4 )

      type = T__53
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 10:9: 'AS'
      match( "AS" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 4 )

    end

    # lexer rule t__54! (T__54)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__54!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 5 )

      type = T__54
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 11:9: 'END'
      match( "END" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 5 )

    end

    # lexer rule t__55! (T__55)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__55!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 6 )

      type = T__55
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 12:9: 'BEGIN'
      match( "BEGIN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 6 )

    end

    # lexer rule t__56! (T__56)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__56!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 7 )

      type = T__56
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 13:9: 'CONSTANT'
      match( "CONSTANT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 7 )

    end

    # lexer rule t__57! (T__57)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__57!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 8 )

      type = T__57
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 14:9: 'NOT'
      match( "NOT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 8 )

    end

    # lexer rule t__58! (T__58)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__58!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 9 )

      type = T__58
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 15:9: 'NULL'
      match( "NULL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 9 )

    end

    # lexer rule t__59! (T__59)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__59!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 10 )

      type = T__59
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 16:9: 'DEFAULT'
      match( "DEFAULT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 10 )

    end

    # lexer rule t__60! (T__60)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__60!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 11 )

      type = T__60
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 17:9: 'DECLARE'
      match( "DECLARE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 11 )

    end

    # lexer rule t__61! (T__61)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__61!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 12 )

      type = T__61
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 18:9: 'EXCEPTION'
      match( "EXCEPTION" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 12 )

    end

    # lexer rule t__62! (T__62)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__62!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 13 )

      type = T__62
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 19:9: 'GOTO'
      match( "GOTO" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 13 )

    end

    # lexer rule t__63! (T__63)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__63!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 14 )

      type = T__63
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 20:9: 'WHEN'
      match( "WHEN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 14 )

    end

    # lexer rule t__64! (T__64)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__64!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 15 )

      type = T__64
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 21:9: 'BINARY_INTEGER'
      match( "BINARY_INTEGER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 15 )

    end

    # lexer rule t__65! (T__65)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__65!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 16 )

      type = T__65
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 22:9: 'BINARY_FLOAT'
      match( "BINARY_FLOAT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 16 )

    end

    # lexer rule t__66! (T__66)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__66!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 17 )

      type = T__66
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 23:9: 'BINARY_DOUBLE'
      match( "BINARY_DOUBLE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 17 )

    end

    # lexer rule t__67! (T__67)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__67!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 18 )

      type = T__67
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 24:9: 'NATURAL'
      match( "NATURAL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 18 )

    end

    # lexer rule t__68! (T__68)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__68!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 19 )

      type = T__68
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 25:9: 'POSITIVE'
      match( "POSITIVE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 19 )

    end

    # lexer rule t__69! (T__69)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__69!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 20 )

      type = T__69
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 26:9: 'NUMBER'
      match( "NUMBER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 20 )

    end

    # lexer rule t__70! (T__70)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__70!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 21 )

      type = T__70
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 27:9: 'NUMERIC'
      match( "NUMERIC" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 21 )

    end

    # lexer rule t__71! (T__71)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__71!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 22 )

      type = T__71
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 28:9: 'DECIMAL'
      match( "DECIMAL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 22 )

    end

    # lexer rule t__72! (T__72)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__72!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 23 )

      type = T__72
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 29:9: 'DEC'
      match( "DEC" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 23 )

    end

    # lexer rule t__73! (T__73)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__73!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 24 )

      type = T__73
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 30:9: 'LONG'
      match( "LONG" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 24 )

    end

    # lexer rule t__74! (T__74)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__74!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 25 )

      type = T__74
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 31:9: 'RAW'
      match( "RAW" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 25 )

    end

    # lexer rule t__75! (T__75)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__75!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 26 )

      type = T__75
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 32:9: 'BOOLEAN'
      match( "BOOLEAN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 26 )

    end

    # lexer rule t__76! (T__76)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__76!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 27 )

      type = T__76
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 33:9: 'DATE'
      match( "DATE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 27 )

    end

    # lexer rule t__77! (T__77)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__77!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 28 )

      type = T__77
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 34:9: 'TO'
      match( "TO" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 28 )

    end

    # lexer rule t__78! (T__78)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__78!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 29 )

      type = T__78
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 35:9: 'WITH'
      match( "WITH" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 29 )

    end

    # lexer rule t__79! (T__79)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__79!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 30 )

      type = T__79
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 36:9: 'INTEGER'
      match( "INTEGER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 30 )

    end

    # lexer rule t__80! (T__80)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__80!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 31 )

      type = T__80
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 37:9: 'INT'
      match( "INT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 31 )

    end

    # lexer rule t__81! (T__81)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__81!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 32 )

      type = T__81
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 38:9: 'SMALLINT'
      match( "SMALLINT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 32 )

    end

    # lexer rule t__82! (T__82)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__82!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 33 )

      type = T__82
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 39:9: 'FLOAT'
      match( "FLOAT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 33 )

    end

    # lexer rule t__83! (T__83)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__83!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 34 )

      type = T__83
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 40:9: 'REAL'
      match( "REAL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 34 )

    end

    # lexer rule t__84! (T__84)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__84!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 35 )

      type = T__84
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 41:9: 'DOUBLE'
      match( "DOUBLE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 35 )

    end

    # lexer rule t__85! (T__85)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__85!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 36 )

      type = T__85
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 42:9: 'CHAR'
      match( "CHAR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 36 )

    end

    # lexer rule t__86! (T__86)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__86!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 37 )

      type = T__86
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 43:9: 'CHARACTER'
      match( "CHARACTER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 37 )

    end

    # lexer rule t__87! (T__87)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__87!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 38 )

      type = T__87
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 44:9: 'SET'
      match( "SET" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 38 )

    end

    # lexer rule t__88! (T__88)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__88!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 39 )

      type = T__88
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 45:9: 'VARCHAR'
      match( "VARCHAR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 39 )

    end

    # lexer rule t__89! (T__89)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__89!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 40 )

      type = T__89
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 46:9: 'VARCHAR2'
      match( "VARCHAR2" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 40 )

    end

    # lexer rule t__90! (T__90)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__90!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 41 )

      type = T__90
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 47:9: 'NCHAR'
      match( "NCHAR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 41 )

    end

    # lexer rule t__91! (T__91)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__91!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 42 )

      type = T__91
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 48:9: 'NVARCHAR'
      match( "NVARCHAR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 42 )

    end

    # lexer rule t__92! (T__92)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__92!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 43 )

      type = T__92
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 49:9: 'NVARCHAR2'
      match( "NVARCHAR2" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 43 )

    end

    # lexer rule t__93! (T__93)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__93!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 44 )

      type = T__93
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 50:9: 'NATIONAL'
      match( "NATIONAL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 44 )

    end

    # lexer rule t__94! (T__94)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__94!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 45 )

      type = T__94
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 51:9: 'MLSLABEL'
      match( "MLSLABEL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 45 )

    end

    # lexer rule t__95! (T__95)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__95!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 46 )

      type = T__95
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 52:9: 'PLS_INTEGER'
      match( "PLS_INTEGER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 46 )

    end

    # lexer rule t__96! (T__96)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__96!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 47 )

      type = T__96
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 53:9: 'BLOB'
      match( "BLOB" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 47 )

    end

    # lexer rule t__97! (T__97)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__97!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 48 )

      type = T__97
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 54:9: 'CLOB'
      match( "CLOB" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 48 )

    end

    # lexer rule t__98! (T__98)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__98!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 49 )

      type = T__98
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 55:9: 'NCLOB'
      match( "NCLOB" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 49 )

    end

    # lexer rule t__99! (T__99)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__99!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 50 )

      type = T__99
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 56:9: 'BFILE'
      match( "BFILE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 50 )

    end

    # lexer rule t__100! (T__100)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__100!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 51 )

      type = T__100
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 57:10: 'ROWID'
      match( "ROWID" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 51 )

    end

    # lexer rule t__101! (T__101)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__101!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 52 )

      type = T__101
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 58:10: 'UROWID'
      match( "UROWID" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 52 )

    end

    # lexer rule t__102! (T__102)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__102!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 53 )

      type = T__102
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 59:10: 'IN'
      match( "IN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 53 )

    end

    # lexer rule t__103! (T__103)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__103!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 54 )

      type = T__103
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 60:10: 'PROCEDURE'
      match( "PROCEDURE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 54 )

    end

    # lexer rule t__104! (T__104)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__104!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 55 )

      type = T__104
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 61:10: 'FUNCTION'
      match( "FUNCTION" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 55 )

    end

    # lexer rule t__105! (T__105)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__105!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 56 )

      type = T__105
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 62:10: 'TABLE'
      match( "TABLE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 56 )

    end

    # lexer rule t__106! (T__106)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__106!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 57 )

      type = T__106
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 63:10: 'OF'
      match( "OF" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 57 )

    end

    # lexer rule t__107! (T__107)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__107!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 58 )

      type = T__107
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 64:10: 'INDEX'
      match( "INDEX" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 58 )

    end

    # lexer rule t__108! (T__108)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__108!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 59 )

      type = T__108
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 65:10: 'BY'
      match( "BY" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 59 )

    end

    # lexer rule t__109! (T__109)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__109!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 60 )

      type = T__109
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 66:10: 'THEN'
      match( "THEN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 60 )

    end

    # lexer rule t__110! (T__110)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__110!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 61 )

      type = T__110
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 67:10: 'TRUE'
      match( "TRUE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 61 )

    end

    # lexer rule t__111! (T__111)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__111!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 62 )

      type = T__111
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 68:10: 'FALSE'
      match( "FALSE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 62 )

    end

    # lexer rule t__112! (T__112)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__112!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 63 )

      type = T__112
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 69:10: 'FOR'
      match( "FOR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 63 )

    end

    # lexer rule t__113! (T__113)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__113!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 64 )

      type = T__113
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 70:10: 'COMMIT'
      match( "COMMIT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 64 )

    end

    # lexer rule t__114! (T__114)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__114!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 65 )

      type = T__114
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 71:10: 'IF'
      match( "IF" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 65 )

    end

    # lexer rule t__115! (T__115)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__115!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 66 )

      type = T__115
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 72:10: 'ELSE'
      match( "ELSE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 66 )

    end

    # lexer rule t__116! (T__116)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__116!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 67 )

      type = T__116
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 73:10: 'SELECT'
      match( "SELECT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 67 )

    end

    # lexer rule t__117! (T__117)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__117!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 68 )

      type = T__117
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 74:10: 'DISTINCT'
      match( "DISTINCT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 68 )

    end

    # lexer rule t__118! (T__118)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__118!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 69 )

      type = T__118
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 75:10: 'UNIQUE'
      match( "UNIQUE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 69 )

    end

    # lexer rule t__119! (T__119)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__119!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 70 )

      type = T__119
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 76:10: 'ALL'
      match( "ALL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 70 )

    end

    # lexer rule t__120! (T__120)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__120!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 71 )

      type = T__120
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 77:10: 'INTO'
      match( "INTO" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 71 )

    end

    # lexer rule t__121! (T__121)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__121!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 72 )

      type = T__121
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 78:10: 'FROM'
      match( "FROM" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 72 )

    end

    # lexer rule t__122! (T__122)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__122!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 73 )

      type = T__122
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 79:10: 'HAVING'
      match( "HAVING" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 73 )

    end

    # lexer rule t__123! (T__123)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__123!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 74 )

      type = T__123
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 80:10: 'UNION'
      match( "UNION" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 74 )

    end

    # lexer rule t__124! (T__124)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__124!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 75 )

      type = T__124
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 81:10: 'INTERSECT'
      match( "INTERSECT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 75 )

    end

    # lexer rule t__125! (T__125)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__125!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 76 )

      type = T__125
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 82:10: 'MINUS'
      match( "MINUS" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 76 )

    end

    # lexer rule t__126! (T__126)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__126!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 77 )

      type = T__126
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 83:10: 'ON'
      match( "ON" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 77 )

    end

    # lexer rule t__127! (T__127)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__127!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 78 )

      type = T__127
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 84:10: 'WHERE'
      match( "WHERE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 78 )

    end

    # lexer rule t__128! (T__128)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__128!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 79 )

      type = T__128
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 85:10: 'START'
      match( "START" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 79 )

    end

    # lexer rule t__129! (T__129)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__129!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 80 )

      type = T__129
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 86:10: 'CONNECT'
      match( "CONNECT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 80 )

    end

    # lexer rule t__130! (T__130)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__130!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 81 )

      type = T__130
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 87:10: 'GROUP'
      match( "GROUP" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 81 )

    end

    # lexer rule t__131! (T__131)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__131!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 82 )

      type = T__131
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 88:10: 'ROWS'
      match( "ROWS" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 82 )

    end

    # lexer rule t__132! (T__132)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__132!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 83 )

      type = T__132
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 89:10: 'UPDATE'
      match( "UPDATE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 83 )

    end

    # lexer rule t__133! (T__133)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__133!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 84 )

      type = T__133
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 90:10: 'ORDER'
      match( "ORDER" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 84 )

    end

    # lexer rule t__134! (T__134)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__134!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 85 )

      type = T__134
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 91:10: 'LIKE'
      match( "LIKE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 85 )

    end

    # lexer rule t__135! (T__135)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__135!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 86 )

      type = T__135
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 92:10: 'ASC'
      match( "ASC" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 86 )

    end

    # lexer rule t__136! (T__136)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__136!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 87 )

      type = T__136
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 93:10: 'DESC'
      match( "DESC" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 87 )

    end

    # lexer rule t__137! (T__137)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__137!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 88 )

      type = T__137
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 94:10: 'NOWAIT'
      match( "NOWAIT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 88 )

    end

    # lexer rule t__138! (T__138)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__138!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 89 )

      type = T__138
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 95:10: 'AND'
      match( "AND" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 89 )

    end

    # lexer rule t__139! (T__139)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__139!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 90 )

      type = T__139
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 96:10: 'BETWEEN'
      match( "BETWEEN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 90 )

    end

    # lexer rule t__140! (T__140)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__140!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 91 )

      type = T__140
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 97:10: 'SQL'
      match( "SQL" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 91 )

    end

    # lexer rule t__141! (T__141)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__141!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 92 )

      type = T__141
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 98:10: 'PRIOR'
      match( "PRIOR" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 92 )

    end

    # lexer rule t__142! (T__142)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__142!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 93 )

      type = T__142
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 99:10: 'CASE'
      match( "CASE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 93 )

    end

    # lexer rule t__143! (T__143)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__143!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 94 )

      type = T__143
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 100:10: 'AT'
      match( "AT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 94 )

    end

    # lexer rule t__144! (T__144)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__144!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 95 )

      type = T__144
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 101:10: 'EXISTS'
      match( "EXISTS" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 95 )

    end

    # lexer rule t__145! (T__145)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__145!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 96 )

      type = T__145
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 102:10: 'DELETE'
      match( "DELETE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 96 )

    end

    # lexer rule t__146! (T__146)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__146!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 97 )

      type = T__146
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 103:10: 'ANY'
      match( "ANY" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 97 )

    end

    # lexer rule t__147! (T__147)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__147!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 98 )

      type = T__147
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 104:10: 'INSERT'
      match( "INSERT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 98 )

    end

    # lexer rule t__148! (T__148)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__148!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 99 )

      type = T__148
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 105:10: 'VALUES'
      match( "VALUES" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 99 )

    end

    # lexer rule t__149! (T__149)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__149!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 100 )

      type = T__149
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 106:10: 'FETCH'
      match( "FETCH" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 100 )

    end

    # lexer rule t__150! (T__150)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__150!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 101 )

      type = T__150
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 107:10: 'LOCK'
      match( "LOCK" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 101 )

    end

    # lexer rule t__151! (T__151)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__151!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 102 )

      type = T__151
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 108:10: 'MODE'
      match( "MODE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 102 )

    end

    # lexer rule t__152! (T__152)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__152!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 103 )

      type = T__152
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 109:10: 'ROW'
      match( "ROW" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 103 )

    end

    # lexer rule t__153! (T__153)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__153!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 104 )

      type = T__153
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 110:10: 'SHARE'
      match( "SHARE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 104 )

    end

    # lexer rule t__154! (T__154)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__154!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 105 )

      type = T__154
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 111:10: 'EXCLUSIVE'
      match( "EXCLUSIVE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 105 )

    end

    # lexer rule t__155! (T__155)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__155!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 106 )

      type = T__155
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 112:10: 'SAVEPOINT'
      match( "SAVEPOINT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 106 )

    end

    # lexer rule t__156! (T__156)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__156!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 107 )

      type = T__156
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 113:10: 'COMMENT'
      match( "COMMENT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 107 )

    end

    # lexer rule t__157! (T__157)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__157!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 108 )

      type = T__157
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 114:10: 'ELSIF'
      match( "ELSIF" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 108 )

    end

    # lexer rule t__158! (T__158)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__158!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 109 )

      type = T__158
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 115:10: 'LOOP'
      match( "LOOP" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 109 )

    end

    # lexer rule t__159! (T__159)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__159!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 110 )

      type = T__159
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 116:10: 'OUT'
      match( "OUT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 110 )

    end

    # lexer rule t__160! (T__160)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__160!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 111 )

      type = T__160
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 117:10: 'PACKAGE'
      match( "PACKAGE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 111 )

    end

    # lexer rule t__161! (T__161)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__161!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 112 )

      type = T__161
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 118:10: 'PRAGMA'
      match( "PRAGMA" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 112 )

    end

    # lexer rule t__162! (T__162)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__162!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 113 )

      type = T__162
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 119:10: 'RAISE'
      match( "RAISE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 113 )

    end

    # lexer rule t__163! (T__163)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__163!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 114 )

      type = T__163
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 120:10: 'RECORD'
      match( "RECORD" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 114 )

    end

    # lexer rule t__164! (T__164)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__164!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 115 )

      type = T__164
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 121:10: 'RETURN'
      match( "RETURN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 115 )

    end

    # lexer rule t__165! (T__165)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__165!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 116 )

      type = T__165
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 122:10: 'RETURNING'
      match( "RETURNING" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 116 )

    end

    # lexer rule t__166! (T__166)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__166!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 117 )

      type = T__166
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 123:10: 'ROLLBACK'
      match( "ROLLBACK" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 117 )

    end

    # lexer rule t__167! (T__167)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def t__167!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 118 )

      type = T__167
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 124:10: 'WHILE'
      match( "WHILE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 118 )

    end

    # lexer rule quoted_string! (QUOTED_STRING)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def quoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 119 )

      type = QUOTED_STRING
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1416:4: ( 'n' )? '\\'' ( '\\'\\'' | ~ ( '\\'' ) )* '\\''
      # at line 1416:4: ( 'n' )?
      alt_1 = 2
      look_1_0 = @input.peek( 1 )

      if ( look_1_0 == ?n )
        alt_1 = 1
      end
      case alt_1
      when 1
        # at line 1416:6: 'n'
        match( ?n )

      end
      match( ?\' )
      # at line 1416:18: ( '\\'\\'' | ~ ( '\\'' ) )*
      while true # decision 2
        alt_2 = 3
        look_2_0 = @input.peek( 1 )

        if ( look_2_0 == ?\' )
          look_2_1 = @input.peek( 2 )

          if ( look_2_1 == ?\' )
            alt_2 = 1

          end
        elsif ( look_2_0.between?( 0x0000, ?& ) || look_2_0.between?( ?(, 0xFFFF ) )
          alt_2 = 2

        end
        case alt_2
        when 1
          # at line 1416:20: '\\'\\''
          match( "''" )

        when 2
          # at line 1416:29: ~ ( '\\'' )
          if @input.peek( 1 ).between?( 0x0000, ?& ) || @input.peek( 1 ).between?( ?(, 0x00FF )
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          break # out of loop for decision 2
        end
      end # loop for decision 2
      match( ?\' )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 119 )

    end

    # lexer rule id! (ID)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def id!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 120 )

      type = ID
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1419:5: ( 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )* | DOUBLEQUOTED_STRING )
      alt_4 = 2
      look_4_0 = @input.peek( 1 )

      if ( look_4_0.between?( ?A, ?Z ) )
        alt_4 = 1
      elsif ( look_4_0 == ?" )
        alt_4 = 2
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 4, 0 )
      end
      case alt_4
      when 1
        # at line 1419:7: 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        match_range( ?A, ?Z )
        # at line 1419:18: ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        while true # decision 3
          alt_3 = 2
          look_3_0 = @input.peek( 1 )

          if ( look_3_0.between?( ?#, ?$ ) || look_3_0.between?( ?0, ?9 ) || look_3_0.between?( ?A, ?Z ) || look_3_0 == ?_ )
            alt_3 = 1

          end
          case alt_3
          when 1
            # at line 
            if @input.peek( 1 ).between?( ?#, ?$ ) || @input.peek( 1 ).between?( ?0, ?9 ) || @input.peek( 1 ).between?( ?A, ?Z ) || @input.peek(1) == ?_
              @input.consume
            else
              @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

              mse = MismatchedSet( nil )
              recover mse
              raise mse
            end



          else
            break # out of loop for decision 3
          end
        end # loop for decision 3

      when 2
        # at line 1420:7: DOUBLEQUOTED_STRING
        doublequoted_string!

      end
      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 120 )

    end

    # lexer rule semi! (SEMI)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def semi!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 121 )

      type = SEMI
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1423:4: ';'
      match( ?; )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 121 )

    end

    # lexer rule colon! (COLON)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def colon!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 122 )

      type = COLON
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1426:4: ':'
      match( ?: )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 122 )

    end

    # lexer rule doubledot! (DOUBLEDOT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def doubledot!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 123 )

      type = DOUBLEDOT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1429:4: POINT POINT
      point!
      point!

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 123 )

    end

    # lexer rule dot! (DOT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def dot!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 124 )

      type = DOT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1432:4: POINT
      point!

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 124 )

    end

    # lexer rule point! (POINT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def point!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 125 )

      
      # - - - - main rule block - - - -
      # at line 1436:4: '.'
      match( ?. )

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 125 )

    end

    # lexer rule comma! (COMMA)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def comma!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 126 )

      type = COMMA
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1439:4: ','
      match( ?, )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 126 )

    end

    # lexer rule exponent! (EXPONENT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def exponent!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 127 )

      type = EXPONENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1442:4: '**'
      match( "**" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 127 )

    end

    # lexer rule asterisk! (ASTERISK)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def asterisk!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 128 )

      type = ASTERISK
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1445:4: '*'
      match( ?* )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 128 )

    end

    # lexer rule at_sign! (AT_SIGN)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def at_sign!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 129 )

      type = AT_SIGN
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1448:4: '@'
      match( ?@ )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 129 )

    end

    # lexer rule rparen! (RPAREN)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def rparen!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 130 )

      type = RPAREN
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1451:4: ')'
      match( ?) )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 130 )

    end

    # lexer rule lparen! (LPAREN)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def lparen!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 131 )

      type = LPAREN
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1454:4: '('
      match( ?( )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 131 )

    end

    # lexer rule rbrack! (RBRACK)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def rbrack!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 132 )

      type = RBRACK
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1457:4: ']'
      match( ?] )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 132 )

    end

    # lexer rule lbrack! (LBRACK)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def lbrack!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 133 )

      type = LBRACK
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1460:4: '['
      match( ?[ )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 133 )

    end

    # lexer rule plus! (PLUS)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def plus!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 134 )

      type = PLUS
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1463:4: '+'
      match( ?+ )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 134 )

    end

    # lexer rule minus! (MINUS)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def minus!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 135 )

      type = MINUS
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1466:4: '-'
      match( ?- )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 135 )

    end

    # lexer rule divide! (DIVIDE)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def divide!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 136 )

      type = DIVIDE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1469:4: '/'
      match( ?/ )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 136 )

    end

    # lexer rule eq! (EQ)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def eq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 137 )

      type = EQ
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1472:4: '='
      match( ?= )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 137 )

    end

    # lexer rule percentage! (PERCENTAGE)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def percentage!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 138 )

      type = PERCENTAGE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1475:4: '%'
      match( ?% )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 138 )

    end

    # lexer rule llabel! (LLABEL)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def llabel!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 139 )

      type = LLABEL
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1478:4: '<<'
      match( "<<" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 139 )

    end

    # lexer rule rlabel! (RLABEL)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def rlabel!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 140 )

      type = RLABEL
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1481:4: '>>'
      match( ">>" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 140 )

    end

    # lexer rule assign! (ASSIGN)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def assign!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 141 )

      type = ASSIGN
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1484:4: ':='
      match( ":=" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 141 )

    end

    # lexer rule arrow! (ARROW)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def arrow!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 142 )

      type = ARROW
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1487:4: '=>'
      match( "=>" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 142 )

    end

    # lexer rule vertbar! (VERTBAR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def vertbar!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 143 )

      type = VERTBAR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1490:4: '|'
      match( ?| )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 143 )

    end

    # lexer rule doublevertbar! (DOUBLEVERTBAR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def doublevertbar!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 144 )

      type = DOUBLEVERTBAR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1493:4: '||'
      match( "||" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 144 )

    end

    # lexer rule not_eq! (NOT_EQ)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def not_eq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 145 )

      type = NOT_EQ
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1496:2: ( '<>' | '!=' | '^=' )
      alt_5 = 3
      case look_5 = @input.peek( 1 )
      when ?< then alt_5 = 1
      when ?! then alt_5 = 2
      when ?^ then alt_5 = 3
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 5, 0 )
      end
      case alt_5
      when 1
        # at line 1496:4: '<>'
        match( "<>" )

      when 2
        # at line 1496:11: '!='
        match( "!=" )

      when 3
        # at line 1496:18: '^='
        match( "^=" )

      end
      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 145 )

    end

    # lexer rule lth! (LTH)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def lth!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 146 )

      type = LTH
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1499:4: '<'
      match( ?< )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 146 )

    end

    # lexer rule leq! (LEQ)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def leq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 147 )

      type = LEQ
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1502:4: '<='
      match( "<=" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 147 )

    end

    # lexer rule gth! (GTH)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def gth!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 148 )

      type = GTH
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1505:4: '>'
      match( ?> )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 148 )

    end

    # lexer rule geq! (GEQ)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def geq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 149 )

      type = GEQ
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1508:4: '>='
      match( ">=" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 149 )

    end

    # lexer rule number! (NUMBER)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def number!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 150 )

      type = NUMBER
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1512:3: ( ( N POINT N )=> N POINT N | POINT N | N ) ( 'E' ( PLUS | MINUS )? N )?
      # at line 1512:3: ( ( N POINT N )=> N POINT N | POINT N | N )
      alt_6 = 3
      alt_6 = @dfa6.predict( @input )
      case alt_6
      when 1
        # at line 1512:5: ( N POINT N )=> N POINT N
        n!
        point!
        n!

      when 2
        # at line 1513:5: POINT N
        point!
        n!

      when 3
        # at line 1514:5: N
        n!

      end
      # at line 1516:3: ( 'E' ( PLUS | MINUS )? N )?
      alt_8 = 2
      look_8_0 = @input.peek( 1 )

      if ( look_8_0 == ?E )
        alt_8 = 1
      end
      case alt_8
      when 1
        # at line 1516:5: 'E' ( PLUS | MINUS )? N
        match( ?E )
        # at line 1516:9: ( PLUS | MINUS )?
        alt_7 = 2
        look_7_0 = @input.peek( 1 )

        if ( look_7_0 == ?+ || look_7_0 == ?- )
          alt_7 = 1
        end
        case alt_7
        when 1
          # at line 
          if @input.peek(1) == ?+ || @input.peek(1) == ?-
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        end
        n!

      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 150 )

    end

    # lexer rule n! (N)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def n!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 151 )

      
      # - - - - main rule block - - - -
      # at line 1520:4: '0' .. '9' ( '0' .. '9' )*
      match_range( ?0, ?9 )
      # at line 1520:15: ( '0' .. '9' )*
      while true # decision 9
        alt_9 = 2
        look_9_0 = @input.peek( 1 )

        if ( look_9_0.between?( ?0, ?9 ) )
          alt_9 = 1

        end
        case alt_9
        when 1
          # at line 1520:17: '0' .. '9'
          match_range( ?0, ?9 )

        else
          break # out of loop for decision 9
        end
      end # loop for decision 9

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 151 )

    end

    # lexer rule quote! (QUOTE)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def quote!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 152 )

      type = QUOTE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1523:4: '\\''
      match( ?\' )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 152 )

    end

    # lexer rule doublequoted_string! (DOUBLEQUOTED_STRING)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def doublequoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 153 )

      
      # - - - - main rule block - - - -
      # at line 1527:4: '\"' (~ ( '\"' ) )* '\"'
      match( ?" )
      # at line 1527:8: (~ ( '\"' ) )*
      while true # decision 10
        alt_10 = 2
        look_10_0 = @input.peek( 1 )

        if ( look_10_0.between?( 0x0000, ?! ) || look_10_0.between?( ?#, 0xFFFF ) )
          alt_10 = 1

        end
        case alt_10
        when 1
          # at line 1527:10: ~ ( '\"' )
          if @input.peek( 1 ).between?( 0x0000, ?! ) || @input.peek( 1 ).between?( ?#, 0x00FF )
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          break # out of loop for decision 10
        end
      end # loop for decision 10
      match( ?" )

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 153 )

    end

    # lexer rule ws! (WS)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def ws!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 154 )

      type = WS
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1529:6: ( ' ' | '\\r' | '\\t' | '\\n' )
      if @input.peek( 1 ).between?( ?\t, ?\n ) || @input.peek(1) == ?\r || @input.peek(1) == ?\s
        @input.consume
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        mse = MismatchedSet( nil )
        recover mse
        raise mse
      end


      # syntactic predicate action gate test
      if @state.backtracking == 0
        # --> action
        channel=HIDDEN;
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 154 )

    end

    # lexer rule sl_comment! (SL_COMMENT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def sl_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 155 )

      type = SL_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1532:4: '--' (~ ( '\\n' | '\\r' ) )* ( '\\r' )? '\\n'
      match( "--" )
      # at line 1532:9: (~ ( '\\n' | '\\r' ) )*
      while true # decision 11
        alt_11 = 2
        look_11_0 = @input.peek( 1 )

        if ( look_11_0.between?( 0x0000, ?\t ) || look_11_0.between?( 0x000B, ?\f ) || look_11_0.between?( 0x000E, 0xFFFF ) )
          alt_11 = 1

        end
        case alt_11
        when 1
          # at line 1532:9: ~ ( '\\n' | '\\r' )
          if @input.peek( 1 ).between?( 0x0000, ?\t ) || @input.peek( 1 ).between?( 0x000B, ?\f ) || @input.peek( 1 ).between?( 0x000E, 0x00FF )
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          break # out of loop for decision 11
        end
      end # loop for decision 11
      # at line 1532:23: ( '\\r' )?
      alt_12 = 2
      look_12_0 = @input.peek( 1 )

      if ( look_12_0 == ?\r )
        alt_12 = 1
      end
      case alt_12
      when 1
        # at line 1532:23: '\\r'
        match( ?\r )

      end
      match( ?\n )
      # syntactic predicate action gate test
      if @state.backtracking == 0
        # --> action
        channel=HIDDEN;
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 155 )

    end

    # lexer rule ml_comment! (ML_COMMENT)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def ml_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 156 )

      type = ML_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1535:4: '/*' ( options {greedy=false; } : . )* '*/'
      match( "/*" )
      # at line 1535:9: ( options {greedy=false; } : . )*
      while true # decision 13
        alt_13 = 2
        look_13_0 = @input.peek( 1 )

        if ( look_13_0 == ?* )
          look_13_1 = @input.peek( 2 )

          if ( look_13_1 == ?/ )
            alt_13 = 2
          elsif ( look_13_1.between?( 0x0000, ?. ) || look_13_1.between?( ?0, 0xFFFF ) )
            alt_13 = 1

          end
        elsif ( look_13_0.between?( 0x0000, ?) ) || look_13_0.between?( ?+, 0xFFFF ) )
          alt_13 = 1

        end
        case alt_13
        when 1
          # at line 1535:37: .
          match_any

        else
          break # out of loop for decision 13
        end
      end # loop for decision 13
      match( "*/" )
      # syntactic predicate action gate test
      if @state.backtracking == 0
        # --> action
        channel=HIDDEN;
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 156 )

    end

    # lexer rule type_attr! (TYPE_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def type_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 157 )

      type = TYPE_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1538:4: '%TYPE'
      match( "%TYPE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 157 )

    end

    # lexer rule rowtype_attr! (ROWTYPE_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def rowtype_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 158 )

      type = ROWTYPE_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1541:4: '%ROWTYPE'
      match( "%ROWTYPE" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 158 )

    end

    # lexer rule notfound_attr! (NOTFOUND_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def notfound_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 159 )

      type = NOTFOUND_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1544:4: '%NOTFOUND'
      match( "%NOTFOUND" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 159 )

    end

    # lexer rule found_attr! (FOUND_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def found_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 160 )

      type = FOUND_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1547:4: '%FOUND'
      match( "%FOUND" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 160 )

    end

    # lexer rule isopen_attr! (ISOPEN_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def isopen_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 161 )

      type = ISOPEN_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1550:4: '%ISOPEN'
      match( "%ISOPEN" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 161 )

    end

    # lexer rule rowcount_attr! (ROWCOUNT_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def rowcount_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 162 )

      type = ROWCOUNT_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1553:4: '%ROWCOUNT'
      match( "%ROWCOUNT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 162 )

    end

    # lexer rule bulk_rowcount_attr! (BULK_ROWCOUNT_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def bulk_rowcount_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 163 )

      type = BULK_ROWCOUNT_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1556:4: '%BULK_ROWCOUNT'
      match( "%BULK_ROWCOUNT" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 163 )

    end

    # lexer rule charset_attr! (CHARSET_ATTR)
    # (in vorax\\lib\\ruby\\Plsql.g)
    def charset_attr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 164 )

      type = CHARSET_ATTR
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 1559:4: '%CHARSET'
      match( "%CHARSET" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 164 )

    end

    # main rule used to study the input at the current position,
    # and choose the proper lexer rule to call in order to
    # fetch the next token
    # 
    # usually, you don't make direct calls to this method,
    # but instead use the next_token method, which will
    # build and emit the actual next token
    def token!
      # at line 1:8: ( T__50 | T__51 | T__52 | T__53 | T__54 | T__55 | T__56 | T__57 | T__58 | T__59 | T__60 | T__61 | T__62 | T__63 | T__64 | T__65 | T__66 | T__67 | T__68 | T__69 | T__70 | T__71 | T__72 | T__73 | T__74 | T__75 | T__76 | T__77 | T__78 | T__79 | T__80 | T__81 | T__82 | T__83 | T__84 | T__85 | T__86 | T__87 | T__88 | T__89 | T__90 | T__91 | T__92 | T__93 | T__94 | T__95 | T__96 | T__97 | T__98 | T__99 | T__100 | T__101 | T__102 | T__103 | T__104 | T__105 | T__106 | T__107 | T__108 | T__109 | T__110 | T__111 | T__112 | T__113 | T__114 | T__115 | T__116 | T__117 | T__118 | T__119 | T__120 | T__121 | T__122 | T__123 | T__124 | T__125 | T__126 | T__127 | T__128 | T__129 | T__130 | T__131 | T__132 | T__133 | T__134 | T__135 | T__136 | T__137 | T__138 | T__139 | T__140 | T__141 | T__142 | T__143 | T__144 | T__145 | T__146 | T__147 | T__148 | T__149 | T__150 | T__151 | T__152 | T__153 | T__154 | T__155 | T__156 | T__157 | T__158 | T__159 | T__160 | T__161 | T__162 | T__163 | T__164 | T__165 | T__166 | T__167 | QUOTED_STRING | ID | SEMI | COLON | DOUBLEDOT | DOT | COMMA | EXPONENT | ASTERISK | AT_SIGN | RPAREN | LPAREN | RBRACK | LBRACK | PLUS | MINUS | DIVIDE | EQ | PERCENTAGE | LLABEL | RLABEL | ASSIGN | ARROW | VERTBAR | DOUBLEVERTBAR | NOT_EQ | LTH | LEQ | GTH | GEQ | NUMBER | QUOTE | WS | SL_COMMENT | ML_COMMENT | TYPE_ATTR | ROWTYPE_ATTR | NOTFOUND_ATTR | FOUND_ATTR | ISOPEN_ATTR | ROWCOUNT_ATTR | BULK_ROWCOUNT_ATTR | CHARSET_ATTR )
      alt_14 = 161
      alt_14 = @dfa14.predict( @input )
      case alt_14
      when 1
        # at line 1:10: T__50
        t__50!

      when 2
        # at line 1:16: T__51
        t__51!

      when 3
        # at line 1:22: T__52
        t__52!

      when 4
        # at line 1:28: T__53
        t__53!

      when 5
        # at line 1:34: T__54
        t__54!

      when 6
        # at line 1:40: T__55
        t__55!

      when 7
        # at line 1:46: T__56
        t__56!

      when 8
        # at line 1:52: T__57
        t__57!

      when 9
        # at line 1:58: T__58
        t__58!

      when 10
        # at line 1:64: T__59
        t__59!

      when 11
        # at line 1:70: T__60
        t__60!

      when 12
        # at line 1:76: T__61
        t__61!

      when 13
        # at line 1:82: T__62
        t__62!

      when 14
        # at line 1:88: T__63
        t__63!

      when 15
        # at line 1:94: T__64
        t__64!

      when 16
        # at line 1:100: T__65
        t__65!

      when 17
        # at line 1:106: T__66
        t__66!

      when 18
        # at line 1:112: T__67
        t__67!

      when 19
        # at line 1:118: T__68
        t__68!

      when 20
        # at line 1:124: T__69
        t__69!

      when 21
        # at line 1:130: T__70
        t__70!

      when 22
        # at line 1:136: T__71
        t__71!

      when 23
        # at line 1:142: T__72
        t__72!

      when 24
        # at line 1:148: T__73
        t__73!

      when 25
        # at line 1:154: T__74
        t__74!

      when 26
        # at line 1:160: T__75
        t__75!

      when 27
        # at line 1:166: T__76
        t__76!

      when 28
        # at line 1:172: T__77
        t__77!

      when 29
        # at line 1:178: T__78
        t__78!

      when 30
        # at line 1:184: T__79
        t__79!

      when 31
        # at line 1:190: T__80
        t__80!

      when 32
        # at line 1:196: T__81
        t__81!

      when 33
        # at line 1:202: T__82
        t__82!

      when 34
        # at line 1:208: T__83
        t__83!

      when 35
        # at line 1:214: T__84
        t__84!

      when 36
        # at line 1:220: T__85
        t__85!

      when 37
        # at line 1:226: T__86
        t__86!

      when 38
        # at line 1:232: T__87
        t__87!

      when 39
        # at line 1:238: T__88
        t__88!

      when 40
        # at line 1:244: T__89
        t__89!

      when 41
        # at line 1:250: T__90
        t__90!

      when 42
        # at line 1:256: T__91
        t__91!

      when 43
        # at line 1:262: T__92
        t__92!

      when 44
        # at line 1:268: T__93
        t__93!

      when 45
        # at line 1:274: T__94
        t__94!

      when 46
        # at line 1:280: T__95
        t__95!

      when 47
        # at line 1:286: T__96
        t__96!

      when 48
        # at line 1:292: T__97
        t__97!

      when 49
        # at line 1:298: T__98
        t__98!

      when 50
        # at line 1:304: T__99
        t__99!

      when 51
        # at line 1:310: T__100
        t__100!

      when 52
        # at line 1:317: T__101
        t__101!

      when 53
        # at line 1:324: T__102
        t__102!

      when 54
        # at line 1:331: T__103
        t__103!

      when 55
        # at line 1:338: T__104
        t__104!

      when 56
        # at line 1:345: T__105
        t__105!

      when 57
        # at line 1:352: T__106
        t__106!

      when 58
        # at line 1:359: T__107
        t__107!

      when 59
        # at line 1:366: T__108
        t__108!

      when 60
        # at line 1:373: T__109
        t__109!

      when 61
        # at line 1:380: T__110
        t__110!

      when 62
        # at line 1:387: T__111
        t__111!

      when 63
        # at line 1:394: T__112
        t__112!

      when 64
        # at line 1:401: T__113
        t__113!

      when 65
        # at line 1:408: T__114
        t__114!

      when 66
        # at line 1:415: T__115
        t__115!

      when 67
        # at line 1:422: T__116
        t__116!

      when 68
        # at line 1:429: T__117
        t__117!

      when 69
        # at line 1:436: T__118
        t__118!

      when 70
        # at line 1:443: T__119
        t__119!

      when 71
        # at line 1:450: T__120
        t__120!

      when 72
        # at line 1:457: T__121
        t__121!

      when 73
        # at line 1:464: T__122
        t__122!

      when 74
        # at line 1:471: T__123
        t__123!

      when 75
        # at line 1:478: T__124
        t__124!

      when 76
        # at line 1:485: T__125
        t__125!

      when 77
        # at line 1:492: T__126
        t__126!

      when 78
        # at line 1:499: T__127
        t__127!

      when 79
        # at line 1:506: T__128
        t__128!

      when 80
        # at line 1:513: T__129
        t__129!

      when 81
        # at line 1:520: T__130
        t__130!

      when 82
        # at line 1:527: T__131
        t__131!

      when 83
        # at line 1:534: T__132
        t__132!

      when 84
        # at line 1:541: T__133
        t__133!

      when 85
        # at line 1:548: T__134
        t__134!

      when 86
        # at line 1:555: T__135
        t__135!

      when 87
        # at line 1:562: T__136
        t__136!

      when 88
        # at line 1:569: T__137
        t__137!

      when 89
        # at line 1:576: T__138
        t__138!

      when 90
        # at line 1:583: T__139
        t__139!

      when 91
        # at line 1:590: T__140
        t__140!

      when 92
        # at line 1:597: T__141
        t__141!

      when 93
        # at line 1:604: T__142
        t__142!

      when 94
        # at line 1:611: T__143
        t__143!

      when 95
        # at line 1:618: T__144
        t__144!

      when 96
        # at line 1:625: T__145
        t__145!

      when 97
        # at line 1:632: T__146
        t__146!

      when 98
        # at line 1:639: T__147
        t__147!

      when 99
        # at line 1:646: T__148
        t__148!

      when 100
        # at line 1:653: T__149
        t__149!

      when 101
        # at line 1:660: T__150
        t__150!

      when 102
        # at line 1:667: T__151
        t__151!

      when 103
        # at line 1:674: T__152
        t__152!

      when 104
        # at line 1:681: T__153
        t__153!

      when 105
        # at line 1:688: T__154
        t__154!

      when 106
        # at line 1:695: T__155
        t__155!

      when 107
        # at line 1:702: T__156
        t__156!

      when 108
        # at line 1:709: T__157
        t__157!

      when 109
        # at line 1:716: T__158
        t__158!

      when 110
        # at line 1:723: T__159
        t__159!

      when 111
        # at line 1:730: T__160
        t__160!

      when 112
        # at line 1:737: T__161
        t__161!

      when 113
        # at line 1:744: T__162
        t__162!

      when 114
        # at line 1:751: T__163
        t__163!

      when 115
        # at line 1:758: T__164
        t__164!

      when 116
        # at line 1:765: T__165
        t__165!

      when 117
        # at line 1:772: T__166
        t__166!

      when 118
        # at line 1:779: T__167
        t__167!

      when 119
        # at line 1:786: QUOTED_STRING
        quoted_string!

      when 120
        # at line 1:800: ID
        id!

      when 121
        # at line 1:803: SEMI
        semi!

      when 122
        # at line 1:808: COLON
        colon!

      when 123
        # at line 1:814: DOUBLEDOT
        doubledot!

      when 124
        # at line 1:824: DOT
        dot!

      when 125
        # at line 1:828: COMMA
        comma!

      when 126
        # at line 1:834: EXPONENT
        exponent!

      when 127
        # at line 1:843: ASTERISK
        asterisk!

      when 128
        # at line 1:852: AT_SIGN
        at_sign!

      when 129
        # at line 1:860: RPAREN
        rparen!

      when 130
        # at line 1:867: LPAREN
        lparen!

      when 131
        # at line 1:874: RBRACK
        rbrack!

      when 132
        # at line 1:881: LBRACK
        lbrack!

      when 133
        # at line 1:888: PLUS
        plus!

      when 134
        # at line 1:893: MINUS
        minus!

      when 135
        # at line 1:899: DIVIDE
        divide!

      when 136
        # at line 1:906: EQ
        eq!

      when 137
        # at line 1:909: PERCENTAGE
        percentage!

      when 138
        # at line 1:920: LLABEL
        llabel!

      when 139
        # at line 1:927: RLABEL
        rlabel!

      when 140
        # at line 1:934: ASSIGN
        assign!

      when 141
        # at line 1:941: ARROW
        arrow!

      when 142
        # at line 1:947: VERTBAR
        vertbar!

      when 143
        # at line 1:955: DOUBLEVERTBAR
        doublevertbar!

      when 144
        # at line 1:969: NOT_EQ
        not_eq!

      when 145
        # at line 1:976: LTH
        lth!

      when 146
        # at line 1:980: LEQ
        leq!

      when 147
        # at line 1:984: GTH
        gth!

      when 148
        # at line 1:988: GEQ
        geq!

      when 149
        # at line 1:992: NUMBER
        number!

      when 150
        # at line 1:999: QUOTE
        quote!

      when 151
        # at line 1:1005: WS
        ws!

      when 152
        # at line 1:1008: SL_COMMENT
        sl_comment!

      when 153
        # at line 1:1019: ML_COMMENT
        ml_comment!

      when 154
        # at line 1:1030: TYPE_ATTR
        type_attr!

      when 155
        # at line 1:1040: ROWTYPE_ATTR
        rowtype_attr!

      when 156
        # at line 1:1053: NOTFOUND_ATTR
        notfound_attr!

      when 157
        # at line 1:1067: FOUND_ATTR
        found_attr!

      when 158
        # at line 1:1078: ISOPEN_ATTR
        isopen_attr!

      when 159
        # at line 1:1090: ROWCOUNT_ATTR
        rowcount_attr!

      when 160
        # at line 1:1104: BULK_ROWCOUNT_ATTR
        bulk_rowcount_attr!

      when 161
        # at line 1:1123: CHARSET_ATTR
        charset_attr!

      end
    end
    # 
    # syntactic predicate synpred1_Plsql
    # 
    # (in vorax\\lib\\ruby\\Plsql.g)
    # 
    # 
    # This is an imaginary rule inserted by ANTLR to
    # implement a syntactic predicate decision
    # 
    def synpred1_Plsql
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 166 )

      # at line 1512:7: N POINT N
      n!
      point!
      n!

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 166 )

    end

    
    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA6 < ANTLR3::DFA
      EOT = unpack( 1, -1, 1, 4, 1, -1, 1, 4, 2, -1 )
      EOF = unpack( 6, -1 )
      MIN = unpack( 2, 46, 1, -1, 1, 46, 2, -1 )
      MAX = unpack( 2, 57, 1, -1, 1, 57, 2, -1 )
      ACCEPT = unpack( 2, -1, 1, 2, 1, -1, 1, 3, 1, 1 )
      SPECIAL = unpack( 1, -1, 1, 1, 1, -1, 1, 0, 2, -1 )
      TRANSITION = [
        unpack( 1, 2, 1, -1, 10, 1 ),
        unpack( 1, 5, 1, -1, 10, 3 ),
        unpack(  ),
        unpack( 1, 5, 1, -1, 10, 3 ),
        unpack(  ),
        unpack(  )
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 6
      

      def description
        <<-'__dfa_description__'.strip!
          1512:3: ( ( N POINT N )=> N POINT N | POINT N | N )
        __dfa_description__
      end
    end
    class DFA14 < ANTLR3::DFA
      EOT = unpack( 1, -1, 20, 23, 1, -1, 1, 116, 2, -1, 1, 118, 1, 119, 
                     1, -1, 1, 122, 6, -1, 1, 124, 1, 126, 1, 128, 1, 136, 
                     1, 139, 1, 142, 1, 144, 3, -1, 5, 23, 1, 152, 1, 153, 
                     1, 154, 1, 23, 1, 156, 1, 160, 1, 161, 1, 163, 2, 23, 
                     1, 167, 8, 23, 1, 178, 22, 23, 1, 216, 23, 23, 29, 
                     -1, 7, 23, 3, -1, 1, 251, 1, -1, 1, 254, 2, 23, 2, 
                     -1, 1, 257, 1, -1, 1, 258, 1, 259, 1, 260, 1, -1, 1, 
                     261, 9, 23, 1, -1, 1, 273, 8, 23, 1, 286, 20, 23, 1, 
                     308, 4, 23, 1, 315, 1, 23, 1, -1, 4, 23, 1, 321, 2, 
                     23, 1, 324, 5, 23, 1, 330, 11, 23, 1, -1, 4, 23, 1, 
                     350, 1, 351, 1, 352, 1, 23, 1, -1, 1, 23, 1, 356, 1, 
                     -1, 2, 23, 5, -1, 3, 23, 1, 362, 5, 23, 1, 368, 1, 
                     23, 1, -1, 1, 23, 1, 371, 10, 23, 1, -1, 1, 382, 1, 
                     23, 1, 384, 2, 23, 1, 387, 1, 23, 1, 389, 2, 23, 1, 
                     392, 6, 23, 1, 399, 1, 400, 1, 401, 1, 402, 1, -1, 
                     1, 23, 1, 404, 3, 23, 1, 408, 1, -1, 2, 23, 1, 411, 
                     1, 412, 1, 23, 1, -1, 2, 23, 1, -1, 5, 23, 1, -1, 1, 
                     421, 5, 23, 1, 427, 5, 23, 1, -1, 6, 23, 3, -1, 1, 
                     441, 2, 23, 1, -1, 1, 444, 4, 23, 1, -1, 1, 449, 1, 
                     450, 3, 23, 1, -1, 1, 454, 1, 23, 1, -1, 4, 23, 1, 
                     460, 1, 461, 4, 23, 1, -1, 1, 23, 1, -1, 2, 23, 1, 
                     -1, 1, 469, 1, -1, 1, 470, 1, 471, 1, -1, 3, 23, 1, 
                     475, 2, 23, 4, -1, 1, 478, 1, -1, 2, 23, 1, 481, 1, 
                     -1, 1, 23, 1, 483, 2, -1, 2, 23, 1, 486, 1, 487, 1, 
                     23, 1, 489, 1, 23, 1, 491, 1, -1, 1, 492, 3, 23, 1, 
                     496, 1, -1, 2, 23, 1, 499, 2, 23, 2, -1, 1, 502, 2, 
                     23, 1, 505, 2, 23, 1, -1, 2, 23, 1, -1, 1, 510, 2, 
                     23, 1, 513, 2, -1, 3, 23, 1, -1, 1, 517, 1, 518, 3, 
                     23, 2, -1, 4, 23, 1, 526, 1, 527, 1, 23, 3, -1, 3, 
                     23, 1, -1, 1, 532, 1, 23, 1, -1, 1, 534, 1, 536, 1, 
                     -1, 1, 23, 1, -1, 1, 23, 1, 539, 2, -1, 1, 23, 1, -1, 
                     1, 23, 2, -1, 1, 23, 1, 543, 1, 23, 1, -1, 1, 545, 
                     1, 546, 1, -1, 1, 547, 1, 548, 1, -1, 1, 23, 1, 550, 
                     1, -1, 1, 551, 1, 23, 1, 553, 1, 23, 1, -1, 2, 23, 
                     1, -1, 1, 557, 1, 23, 1, 561, 2, -1, 1, 562, 1, 563, 
                     2, 23, 1, 566, 1, 567, 1, 568, 2, -1, 4, 23, 1, -1, 
                     1, 573, 1, -1, 1, 23, 1, -1, 2, 23, 1, -1, 2, 23, 1, 
                     580, 1, -1, 1, 23, 4, -1, 1, 582, 2, -1, 1, 23, 1, 
                     -1, 3, 23, 1, -1, 3, 23, 3, -1, 1, 590, 1, 592, 3, 
                     -1, 1, 593, 1, 594, 2, 23, 1, -1, 1, 23, 1, 598, 1, 
                     599, 1, 23, 1, 601, 1, 602, 1, -1, 1, 603, 1, -1, 1, 
                     604, 1, 605, 1, 606, 1, 607, 3, 23, 1, -1, 1, 611, 
                     3, -1, 1, 23, 1, 613, 1, 614, 2, -1, 1, 615, 7, -1, 
                     3, 23, 1, -1, 1, 23, 3, -1, 3, 23, 1, 623, 1, 23, 1, 
                     625, 1, 23, 1, -1, 1, 23, 1, -1, 1, 628, 1, 629, 2, 
                     -1 )
      EOF = unpack( 630, -1 )
      MIN = unpack( 1, 9, 1, 65, 2, 70, 2, 76, 1, 69, 2, 65, 1, 79, 1, 
                     72, 1, 65, 1, 73, 5, 65, 1, 73, 1, 78, 1, 65, 1, -1, 
                     1, 0, 2, -1, 1, 61, 1, 46, 1, -1, 1, 42, 6, -1, 1, 
                     45, 1, 42, 1, 62, 1, 66, 1, 60, 1, 61, 1, 124, 3, -1, 
                     1, 69, 1, 77, 1, 65, 1, 79, 1, 83, 3, 35, 1, 84, 4, 
                     35, 1, 76, 1, 68, 1, 35, 1, 68, 1, 67, 1, 83, 1, 71, 
                     1, 78, 2, 79, 1, 73, 1, 35, 1, 84, 1, 76, 1, 84, 1, 
                     72, 1, 65, 1, 67, 1, 84, 1, 85, 1, 83, 1, 84, 1, 79, 
                     1, 69, 1, 84, 2, 83, 1, 65, 2, 67, 1, 75, 1, 73, 1, 
                     65, 1, 76, 1, 35, 1, 66, 1, 69, 1, 85, 1, 65, 1, 76, 
                     1, 65, 1, 76, 1, 65, 1, 86, 1, 79, 1, 78, 1, 76, 1, 
                     82, 1, 79, 1, 84, 1, 76, 1, 83, 1, 78, 1, 68, 1, 79, 
                     1, 73, 1, 68, 1, 86, 14, -1, 1, 79, 14, -1, 1, 65, 
                     1, 78, 1, 77, 1, 82, 1, 66, 2, 69, 3, -1, 1, 35, 1, 
                     -1, 1, 35, 2, 69, 2, -1, 1, 35, 1, -1, 3, 35, 1, -1, 
                     1, 35, 1, 69, 1, 83, 1, 69, 1, 73, 1, 87, 1, 65, 1, 
                     76, 1, 66, 1, 76, 1, -1, 1, 35, 1, 65, 1, 76, 1, 66, 
                     1, 73, 1, 65, 1, 79, 1, 82, 1, 65, 1, 35, 1, 67, 2, 
                     69, 1, 66, 1, 84, 1, 79, 1, 85, 1, 78, 1, 76, 1, 72, 
                     1, 73, 1, 95, 1, 67, 1, 79, 1, 71, 1, 75, 1, 71, 1, 
                     75, 1, 80, 1, 69, 1, 35, 1, 83, 1, 76, 1, 79, 1, 85, 
                     1, 35, 1, 76, 1, -1, 1, 76, 1, 78, 1, 69, 1, 76, 1, 
                     35, 1, 69, 1, 82, 1, 35, 1, 82, 1, 69, 1, 65, 1, 67, 
                     1, 83, 1, 35, 1, 77, 2, 67, 1, 85, 1, 76, 1, 85, 1, 
                     69, 1, 87, 1, 79, 1, 65, 1, 73, 1, 87, 2, 84, 2, 69, 
                     3, 35, 1, 82, 1, -1, 1, 71, 1, 35, 1, -1, 1, 88, 1, 
                     82, 5, -1, 1, 80, 1, 85, 1, 84, 1, 35, 1, 70, 1, 78, 
                     1, 69, 1, 82, 1, 69, 1, 35, 1, 69, 1, -1, 1, 73, 1, 
                     35, 1, 69, 2, 82, 1, 79, 1, 82, 1, 66, 1, 67, 1, 85, 
                     1, 65, 1, 77, 1, -1, 1, 35, 1, 84, 1, 35, 1, 76, 1, 
                     73, 1, 35, 1, 80, 1, 35, 2, 69, 1, 35, 1, 84, 1, 73, 
                     1, 69, 1, 82, 1, 77, 1, 65, 4, 35, 1, -1, 1, 69, 1, 
                     35, 2, 82, 1, 68, 1, 35, 1, -1, 1, 66, 1, 69, 2, 35, 
                     1, 76, 1, -1, 1, 67, 1, 84, 1, -1, 1, 69, 1, 80, 2, 
                     84, 1, 69, 1, -1, 1, 35, 2, 72, 1, 69, 1, 65, 1, 83, 
                     1, 35, 1, 73, 1, 85, 1, 78, 1, 84, 1, 78, 1, 67, 1, 
                     69, 1, 65, 1, 67, 1, 84, 1, 78, 1, 67, 3, -1, 1, 35, 
                     1, 69, 1, 83, 1, -1, 1, 35, 2, 84, 2, 83, 1, -1, 2, 
                     35, 1, 69, 1, 89, 1, 65, 1, -1, 1, 35, 1, 84, 1, -1, 
                     1, 82, 1, 73, 1, 65, 1, 78, 2, 35, 1, 72, 1, 76, 1, 
                     82, 1, 65, 1, -1, 1, 69, 1, -1, 1, 69, 1, 78, 1, -1, 
                     1, 35, 1, -1, 2, 35, 1, -1, 1, 73, 1, 78, 1, 68, 1, 
                     35, 1, 65, 1, 71, 4, -1, 1, 35, 1, -1, 1, 68, 1, 78, 
                     1, 35, 1, -1, 1, 65, 1, 35, 2, -1, 1, 73, 1, 84, 2, 
                     35, 1, 79, 1, 35, 1, 73, 1, 35, 1, -1, 1, 35, 1, 65, 
                     1, 83, 1, 66, 1, 35, 1, -1, 1, 68, 1, 69, 1, 35, 1, 
                     69, 1, 71, 2, -1, 1, 35, 1, 78, 1, 84, 1, 35, 2, 84, 
                     1, -1, 1, 82, 1, 69, 1, -1, 1, 35, 2, 73, 1, 35, 2, 
                     -1, 1, 78, 1, 95, 1, 78, 1, -1, 2, 35, 1, 67, 1, 76, 
                     1, 65, 2, -1, 1, 65, 1, 84, 1, 69, 1, 76, 2, 35, 1, 
                     67, 3, -1, 1, 86, 1, 84, 1, 85, 1, -1, 1, 35, 1, 69, 
                     1, -1, 2, 35, 1, -1, 1, 67, 1, -1, 1, 78, 1, 35, 2, 
                     -1, 1, 73, 1, -1, 1, 79, 2, -1, 1, 82, 1, 35, 1, 69, 
                     1, -1, 2, 35, 1, -1, 2, 35, 1, -1, 1, 84, 1, 35, 1, 
                     -1, 1, 35, 1, 69, 1, 35, 1, 67, 1, -1, 1, 79, 1, 86, 
                     1, -1, 1, 35, 1, 68, 1, 35, 2, -1, 2, 35, 1, 76, 1, 
                     82, 3, 35, 2, -1, 1, 84, 2, 69, 1, 82, 1, -1, 1, 35, 
                     1, -1, 1, 78, 1, -1, 1, 75, 1, 84, 1, -1, 2, 78, 1, 
                     35, 1, -1, 1, 76, 4, -1, 1, 35, 2, -1, 1, 82, 1, -1, 
                     1, 84, 1, 78, 1, 69, 1, -1, 1, 78, 1, 76, 1, 79, 3, 
                     -1, 2, 35, 3, -1, 2, 35, 1, 71, 1, 69, 1, -1, 1, 71, 
                     2, 35, 1, 84, 2, 35, 1, -1, 1, 35, 1, -1, 4, 35, 1, 
                     84, 1, 79, 1, 85, 1, -1, 1, 35, 3, -1, 1, 69, 2, 35, 
                     2, -1, 1, 35, 7, -1, 1, 69, 1, 65, 1, 66, 1, -1, 1, 
                     82, 3, -1, 1, 71, 1, 84, 1, 76, 1, 35, 1, 69, 1, 35, 
                     1, 69, 1, -1, 1, 82, 1, -1, 2, 35, 2, -1 )
      MAX = unpack( 1, 124, 1, 82, 1, 85, 1, 83, 1, 84, 1, 88, 1, 89, 1, 
                     86, 1, 79, 1, 82, 1, 73, 1, 82, 2, 79, 1, 82, 1, 84, 
                     1, 85, 1, 65, 1, 79, 1, 82, 1, 65, 1, -1, 1, -1, 2, 
                     -1, 1, 61, 1, 57, 1, -1, 1, 42, 6, -1, 1, 45, 1, 42, 
                     1, 62, 1, 84, 2, 62, 1, 124, 3, -1, 1, 69, 1, 78, 1, 
                     65, 1, 79, 1, 83, 3, 95, 1, 84, 4, 95, 1, 76, 1, 89, 
                     1, 95, 1, 68, 1, 73, 1, 83, 1, 84, 1, 78, 2, 79, 1, 
                     73, 1, 95, 1, 87, 1, 77, 1, 84, 1, 76, 1, 65, 1, 83, 
                     1, 84, 1, 85, 1, 83, 1, 84, 1, 79, 1, 73, 1, 84, 2, 
                     83, 1, 79, 1, 67, 1, 79, 1, 75, 1, 87, 1, 84, 1, 87, 
                     1, 95, 1, 66, 1, 69, 1, 85, 1, 65, 1, 84, 1, 65, 1, 
                     76, 1, 65, 1, 86, 1, 79, 1, 78, 1, 76, 1, 82, 1, 79, 
                     1, 84, 1, 82, 1, 83, 1, 78, 1, 68, 1, 79, 1, 73, 1, 
                     68, 1, 86, 14, -1, 1, 79, 14, -1, 1, 65, 1, 83, 1, 
                     77, 1, 82, 1, 66, 2, 69, 3, -1, 1, 95, 1, -1, 1, 95, 
                     2, 69, 2, -1, 1, 95, 1, -1, 3, 95, 1, -1, 1, 95, 1, 
                     76, 1, 83, 2, 73, 1, 87, 1, 65, 1, 76, 1, 66, 1, 76, 
                     1, -1, 1, 95, 1, 65, 1, 76, 1, 69, 1, 85, 1, 65, 1, 
                     79, 1, 82, 1, 65, 1, 95, 1, 67, 2, 69, 1, 66, 1, 84, 
                     1, 79, 1, 85, 1, 82, 1, 76, 1, 72, 1, 73, 1, 95, 1, 
                     67, 1, 79, 1, 71, 1, 75, 1, 71, 1, 75, 1, 80, 1, 69, 
                     1, 95, 1, 83, 1, 76, 1, 79, 1, 85, 1, 95, 1, 76, 1, 
                     -1, 1, 76, 1, 78, 1, 69, 1, 76, 1, 95, 1, 69, 1, 82, 
                     1, 95, 1, 82, 1, 69, 1, 65, 1, 67, 1, 83, 1, 95, 1, 
                     77, 2, 67, 1, 85, 1, 76, 1, 85, 1, 69, 1, 87, 1, 81, 
                     1, 65, 1, 73, 1, 87, 2, 84, 1, 69, 1, 73, 3, 95, 1, 
                     82, 1, -1, 1, 82, 1, 95, 1, -1, 1, 88, 1, 82, 5, -1, 
                     1, 80, 1, 85, 1, 84, 1, 95, 1, 70, 1, 78, 1, 69, 1, 
                     82, 1, 69, 1, 95, 1, 69, 1, -1, 1, 73, 1, 95, 1, 69, 
                     2, 82, 1, 79, 1, 82, 1, 66, 1, 67, 1, 85, 1, 65, 1, 
                     77, 1, -1, 1, 95, 1, 84, 1, 95, 1, 76, 1, 73, 1, 95, 
                     1, 80, 1, 95, 2, 69, 1, 95, 1, 84, 1, 73, 1, 69, 1, 
                     82, 1, 77, 1, 65, 4, 95, 1, -1, 1, 69, 1, 95, 2, 82, 
                     1, 68, 1, 95, 1, -1, 1, 66, 1, 69, 2, 95, 1, 76, 1, 
                     -1, 1, 67, 1, 84, 1, -1, 1, 69, 1, 80, 2, 84, 1, 69, 
                     1, -1, 1, 95, 2, 72, 1, 69, 1, 65, 1, 83, 1, 95, 1, 
                     73, 1, 85, 1, 78, 1, 84, 1, 78, 1, 84, 1, 69, 1, 65, 
                     1, 67, 1, 84, 1, 78, 1, 67, 3, -1, 1, 95, 1, 69, 1, 
                     83, 1, -1, 1, 95, 2, 84, 2, 83, 1, -1, 2, 95, 1, 69, 
                     1, 89, 1, 65, 1, -1, 1, 95, 1, 84, 1, -1, 1, 82, 1, 
                     73, 1, 65, 1, 78, 2, 95, 1, 72, 1, 76, 1, 82, 1, 65, 
                     1, -1, 1, 69, 1, -1, 1, 69, 1, 78, 1, -1, 1, 95, 1, 
                     -1, 2, 95, 1, -1, 1, 73, 1, 78, 1, 68, 1, 95, 1, 65, 
                     1, 71, 4, -1, 1, 95, 1, -1, 1, 68, 1, 78, 1, 95, 1, 
                     -1, 1, 65, 1, 95, 2, -1, 1, 73, 1, 84, 2, 95, 1, 79, 
                     1, 95, 1, 73, 1, 95, 1, -1, 1, 95, 1, 65, 1, 83, 1, 
                     66, 1, 95, 1, -1, 1, 68, 1, 69, 1, 95, 1, 69, 1, 71, 
                     2, -1, 1, 95, 1, 78, 1, 84, 1, 95, 2, 84, 1, -1, 1, 
                     82, 1, 69, 1, -1, 1, 95, 2, 73, 1, 95, 2, -1, 1, 78, 
                     1, 95, 1, 78, 1, -1, 2, 95, 1, 67, 1, 76, 1, 65, 2, 
                     -1, 1, 65, 1, 84, 1, 69, 1, 76, 2, 95, 1, 67, 3, -1, 
                     1, 86, 1, 84, 1, 85, 1, -1, 1, 95, 1, 69, 1, -1, 2, 
                     95, 1, -1, 1, 67, 1, -1, 1, 78, 1, 95, 2, -1, 1, 73, 
                     1, -1, 1, 79, 2, -1, 1, 82, 1, 95, 1, 69, 1, -1, 2, 
                     95, 1, -1, 2, 95, 1, -1, 1, 84, 1, 95, 1, -1, 1, 95, 
                     1, 69, 1, 95, 1, 67, 1, -1, 1, 79, 1, 86, 1, -1, 1, 
                     95, 1, 73, 1, 95, 2, -1, 2, 95, 1, 76, 1, 82, 3, 95, 
                     2, -1, 1, 84, 2, 69, 1, 82, 1, -1, 1, 95, 1, -1, 1, 
                     78, 1, -1, 1, 75, 1, 84, 1, -1, 2, 78, 1, 95, 1, -1, 
                     1, 76, 4, -1, 1, 95, 2, -1, 1, 82, 1, -1, 1, 84, 1, 
                     78, 1, 69, 1, -1, 1, 78, 1, 76, 1, 79, 3, -1, 2, 95, 
                     3, -1, 2, 95, 1, 71, 1, 69, 1, -1, 1, 71, 2, 95, 1, 
                     84, 2, 95, 1, -1, 1, 95, 1, -1, 4, 95, 1, 84, 1, 79, 
                     1, 85, 1, -1, 1, 95, 3, -1, 1, 69, 2, 95, 2, -1, 1, 
                     95, 7, -1, 1, 69, 1, 65, 1, 66, 1, -1, 1, 82, 3, -1, 
                     1, 71, 1, 84, 1, 76, 1, 95, 1, 69, 1, 95, 1, 69, 1, 
                     -1, 1, 82, 1, -1, 2, 95, 2, -1 )
      ACCEPT = unpack( 21, -1, 1, 119, 1, -1, 1, 120, 1, 121, 2, -1, 1, 
                        125, 1, -1, 1, 128, 1, 129, 1, 130, 1, 131, 1, 132, 
                        1, 133, 7, -1, 1, 144, 1, 149, 1, 151, 71, -1, 1, 
                        150, 1, 140, 1, 122, 1, 124, 1, 123, 1, 126, 1, 
                        127, 1, 152, 1, 134, 1, 153, 1, 135, 1, 141, 1, 
                        136, 1, 154, 1, -1, 1, 156, 1, 157, 1, 158, 1, 160, 
                        1, 161, 1, 137, 1, 138, 1, 146, 1, 145, 1, 139, 
                        1, 148, 1, 147, 1, 143, 1, 142, 7, -1, 1, 2, 1, 
                        57, 1, 77, 1, -1, 1, 3, 3, -1, 1, 53, 1, 65, 1, 
                        -1, 1, 4, 3, -1, 1, 94, 10, -1, 1, 59, 37, -1, 1, 
                        28, 34, -1, 1, 110, 2, -1, 1, 31, 2, -1, 1, 86, 
                        1, 70, 1, 89, 1, 97, 1, 5, 11, -1, 1, 8, 12, -1, 
                        1, 23, 21, -1, 1, 25, 6, -1, 1, 103, 5, -1, 1, 38, 
                        2, -1, 1, 91, 5, -1, 1, 63, 19, -1, 1, 36, 1, 48, 
                        1, 93, 3, -1, 1, 71, 5, -1, 1, 66, 5, -1, 1, 47, 
                        2, -1, 1, 9, 10, -1, 1, 87, 1, -1, 1, 27, 2, -1, 
                        1, 13, 1, -1, 1, 14, 2, -1, 1, 29, 6, -1, 1, 24, 
                        1, 101, 1, 109, 1, 85, 1, -1, 1, 34, 3, -1, 1, 82, 
                        2, -1, 1, 60, 1, 61, 8, -1, 1, 72, 5, -1, 1, 102, 
                        5, -1, 1, 155, 1, 159, 6, -1, 1, 84, 2, -1, 1, 58, 
                        4, -1, 1, 108, 1, 6, 3, -1, 1, 50, 5, -1, 1, 41, 
                        1, 49, 7, -1, 1, 81, 1, 78, 1, 118, 3, -1, 1, 92, 
                        2, -1, 1, 113, 2, -1, 1, 51, 1, -1, 1, 56, 2, -1, 
                        1, 79, 1, 104, 1, -1, 1, 33, 1, -1, 1, 62, 1, 100, 
                        3, -1, 1, 76, 2, -1, 1, 74, 2, -1, 1, 1, 2, -1, 
                        1, 64, 4, -1, 1, 98, 2, -1, 1, 95, 3, -1, 1, 88, 
                        1, 20, 7, -1, 1, 96, 1, 35, 4, -1, 1, 112, 1, -1, 
                        1, 114, 1, -1, 1, 115, 2, -1, 1, 67, 3, -1, 1, 99, 
                        1, -1, 1, 52, 1, 69, 1, 83, 1, 73, 1, -1, 1, 80, 
                        1, 107, 1, -1, 1, 30, 3, -1, 1, 90, 3, -1, 1, 26, 
                        1, 21, 1, 18, 2, -1, 1, 10, 1, 11, 1, 22, 4, -1, 
                        1, 111, 6, -1, 1, 39, 1, -1, 1, 7, 7, -1, 1, 44, 
                        1, -1, 1, 42, 1, 68, 1, 19, 3, -1, 1, 117, 1, 32, 
                        1, -1, 1, 55, 1, 40, 1, 45, 1, 37, 1, 75, 1, 12, 
                        1, 105, 3, -1, 1, 43, 1, -1, 1, 54, 1, 116, 1, 106, 
                        7, -1, 1, 46, 1, -1, 1, 16, 2, -1, 1, 17, 1, 15 )
      SPECIAL = unpack( 22, -1, 1, 0, 607, -1 )
      TRANSITION = [
        unpack( 2, 44, 2, -1, 1, 44, 18, -1, 1, 44, 1, 42, 1, 23, 2, -1, 
                 1, 38, 1, -1, 1, 22, 1, 31, 1, 30, 1, 28, 1, 34, 1, 27, 
                 1, 35, 1, 26, 1, 36, 10, 43, 1, 25, 1, 24, 1, 39, 1, 37, 
                 1, 40, 1, -1, 1, 29, 1, 4, 1, 6, 1, 1, 1, 8, 1, 5, 1, 16, 
                 1, 9, 1, 20, 1, 3, 2, 23, 1, 12, 1, 18, 1, 7, 1, 2, 1, 
                 11, 1, 23, 1, 13, 1, 15, 1, 14, 1, 19, 1, 17, 1, 10, 3, 
                 23, 1, 33, 1, -1, 1, 32, 1, 42, 15, -1, 1, 21, 13, -1, 
                 1, 41 ),
        unpack( 1, 49, 6, -1, 1, 47, 3, -1, 1, 48, 2, -1, 1, 46, 2, -1, 
                  1, 45 ),
        unpack( 1, 51, 7, -1, 1, 52, 3, -1, 1, 50, 2, -1, 1, 53 ),
        unpack( 1, 56, 7, -1, 1, 55, 4, -1, 1, 54 ),
        unpack( 1, 58, 1, -1, 1, 59, 4, -1, 1, 57, 1, 60 ),
        unpack( 1, 63, 1, -1, 1, 61, 9, -1, 1, 62 ),
        unpack( 1, 64, 1, 68, 2, -1, 1, 65, 2, -1, 1, 67, 2, -1, 1, 66, 
                  9, -1, 1, 69 ),
        unpack( 1, 72, 1, -1, 1, 73, 11, -1, 1, 70, 5, -1, 1, 71, 1, 74 ),
        unpack( 1, 76, 3, -1, 1, 75, 3, -1, 1, 78, 5, -1, 1, 77 ),
        unpack( 1, 79, 2, -1, 1, 80 ),
        unpack( 1, 81, 1, 82 ),
        unpack( 1, 86, 10, -1, 1, 84, 2, -1, 1, 83, 2, -1, 1, 85 ),
        unpack( 1, 88, 5, -1, 1, 87 ),
        unpack( 1, 89, 3, -1, 1, 90, 9, -1, 1, 91 ),
        unpack( 1, 93, 6, -1, 1, 94, 6, -1, 1, 92, 2, -1, 1, 95 ),
        unpack( 1, 101, 3, -1, 1, 97, 2, -1, 1, 100, 4, -1, 1, 96, 3, 
                  -1, 1, 99, 2, -1, 1, 98 ),
        unpack( 1, 104, 3, -1, 1, 107, 6, -1, 1, 102, 2, -1, 1, 105, 2, 
                  -1, 1, 106, 2, -1, 1, 103 ),
        unpack( 1, 108 ),
        unpack( 1, 110, 2, -1, 1, 109, 2, -1, 1, 111 ),
        unpack( 1, 113, 1, -1, 1, 114, 1, -1, 1, 112 ),
        unpack( 1, 115 ),
        unpack(  ),
        unpack( 0, 21 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 117 ),
        unpack( 1, 120, 1, -1, 10, 43 ),
        unpack(  ),
        unpack( 1, 121 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 123 ),
        unpack( 1, 125 ),
        unpack( 1, 127 ),
        unpack( 1, 134, 1, 135, 2, -1, 1, 132, 2, -1, 1, 133, 4, -1, 1, 
                  131, 3, -1, 1, 130, 1, -1, 1, 129 ),
        unpack( 1, 137, 1, 138, 1, 42 ),
        unpack( 1, 141, 1, 140 ),
        unpack( 1, 143 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 145 ),
        unpack( 1, 147, 1, 146 ),
        unpack( 1, 148 ),
        unpack( 1, 149 ),
        unpack( 1, 150 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 3, 23, 1, 151, 22, 23, 4, 
                  -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 155 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 3, 23, 1, 158, 14, 23, 1, 
                  159, 1, 157, 6, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 2, 23, 1, 162, 23, 23, 4, 
                  -1, 1, 23 ),
        unpack( 1, 164 ),
        unpack( 1, 165, 20, -1, 1, 166 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 168 ),
        unpack( 1, 169, 5, -1, 1, 170 ),
        unpack( 1, 171 ),
        unpack( 1, 172, 12, -1, 1, 173 ),
        unpack( 1, 174 ),
        unpack( 1, 175 ),
        unpack( 1, 176 ),
        unpack( 1, 177 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 179, 2, -1, 1, 180 ),
        unpack( 1, 181, 1, 182 ),
        unpack( 1, 183 ),
        unpack( 1, 184, 3, -1, 1, 185 ),
        unpack( 1, 186 ),
        unpack( 1, 188, 2, -1, 1, 187, 5, -1, 1, 190, 6, -1, 1, 189 ),
        unpack( 1, 191 ),
        unpack( 1, 192 ),
        unpack( 1, 193 ),
        unpack( 1, 194 ),
        unpack( 1, 195 ),
        unpack( 1, 196, 3, -1, 1, 197 ),
        unpack( 1, 198 ),
        unpack( 1, 199 ),
        unpack( 1, 200 ),
        unpack( 1, 203, 7, -1, 1, 202, 5, -1, 1, 201 ),
        unpack( 1, 204 ),
        unpack( 1, 206, 10, -1, 1, 205, 1, 207 ),
        unpack( 1, 208 ),
        unpack( 1, 210, 13, -1, 1, 209 ),
        unpack( 1, 211, 1, -1, 1, 212, 16, -1, 1, 213 ),
        unpack( 1, 215, 10, -1, 1, 214 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 217 ),
        unpack( 1, 218 ),
        unpack( 1, 219 ),
        unpack( 1, 220 ),
        unpack( 1, 222, 7, -1, 1, 221 ),
        unpack( 1, 223 ),
        unpack( 1, 224 ),
        unpack( 1, 225 ),
        unpack( 1, 226 ),
        unpack( 1, 227 ),
        unpack( 1, 228 ),
        unpack( 1, 229 ),
        unpack( 1, 230 ),
        unpack( 1, 231 ),
        unpack( 1, 232 ),
        unpack( 1, 234, 5, -1, 1, 233 ),
        unpack( 1, 235 ),
        unpack( 1, 236 ),
        unpack( 1, 237 ),
        unpack( 1, 238 ),
        unpack( 1, 239 ),
        unpack( 1, 240 ),
        unpack( 1, 241 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 242 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 243 ),
        unpack( 1, 245, 4, -1, 1, 244 ),
        unpack( 1, 246 ),
        unpack( 1, 247 ),
        unpack( 1, 248 ),
        unpack( 1, 249 ),
        unpack( 1, 250 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 4, 23, 1, 252, 9, 23, 1, 
                  253, 11, 23, 4, -1, 1, 23 ),
        unpack( 1, 255 ),
        unpack( 1, 256 ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 262, 6, -1, 1, 263 ),
        unpack( 1, 264 ),
        unpack( 1, 265, 3, -1, 1, 266 ),
        unpack( 1, 267 ),
        unpack( 1, 268 ),
        unpack( 1, 269 ),
        unpack( 1, 270 ),
        unpack( 1, 271 ),
        unpack( 1, 272 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 274 ),
        unpack( 1, 275 ),
        unpack( 1, 276, 2, -1, 1, 277 ),
        unpack( 1, 279, 11, -1, 1, 278 ),
        unpack( 1, 280 ),
        unpack( 1, 281 ),
        unpack( 1, 282 ),
        unpack( 1, 283 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 8, 23, 1, 285, 2, 23, 1, 
                  284, 14, 23, 4, -1, 1, 23 ),
        unpack( 1, 287 ),
        unpack( 1, 288 ),
        unpack( 1, 289 ),
        unpack( 1, 290 ),
        unpack( 1, 291 ),
        unpack( 1, 292 ),
        unpack( 1, 293 ),
        unpack( 1, 294, 3, -1, 1, 295 ),
        unpack( 1, 296 ),
        unpack( 1, 297 ),
        unpack( 1, 298 ),
        unpack( 1, 299 ),
        unpack( 1, 300 ),
        unpack( 1, 301 ),
        unpack( 1, 302 ),
        unpack( 1, 303 ),
        unpack( 1, 304 ),
        unpack( 1, 305 ),
        unpack( 1, 306 ),
        unpack( 1, 307 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 309 ),
        unpack( 1, 310 ),
        unpack( 1, 311 ),
        unpack( 1, 312 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 8, 23, 1, 313, 9, 23, 1, 
                  314, 7, 23, 4, -1, 1, 23 ),
        unpack( 1, 316 ),
        unpack(  ),
        unpack( 1, 317 ),
        unpack( 1, 318 ),
        unpack( 1, 319 ),
        unpack( 1, 320 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 322 ),
        unpack( 1, 323 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 325 ),
        unpack( 1, 326 ),
        unpack( 1, 327 ),
        unpack( 1, 328 ),
        unpack( 1, 329 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 331 ),
        unpack( 1, 332 ),
        unpack( 1, 333 ),
        unpack( 1, 334 ),
        unpack( 1, 335 ),
        unpack( 1, 336 ),
        unpack( 1, 337 ),
        unpack( 1, 338 ),
        unpack( 1, 340, 1, -1, 1, 339 ),
        unpack( 1, 341 ),
        unpack( 1, 342 ),
        unpack( 1, 343 ),
        unpack( 1, 344 ),
        unpack( 1, 345 ),
        unpack( 1, 346 ),
        unpack( 1, 348, 3, -1, 1, 347 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 1, 349, 25, 23, 4, -1, 1, 
                  23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 353 ),
        unpack(  ),
        unpack( 1, 354, 10, -1, 1, 355 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 357 ),
        unpack( 1, 358 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 359 ),
        unpack( 1, 360 ),
        unpack( 1, 361 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 363 ),
        unpack( 1, 364 ),
        unpack( 1, 365 ),
        unpack( 1, 366 ),
        unpack( 1, 367 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 369 ),
        unpack(  ),
        unpack( 1, 370 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 372 ),
        unpack( 1, 373 ),
        unpack( 1, 374 ),
        unpack( 1, 375 ),
        unpack( 1, 376 ),
        unpack( 1, 377 ),
        unpack( 1, 378 ),
        unpack( 1, 379 ),
        unpack( 1, 380 ),
        unpack( 1, 381 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 383 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 385 ),
        unpack( 1, 386 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 388 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 390 ),
        unpack( 1, 391 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 393 ),
        unpack( 1, 394 ),
        unpack( 1, 395 ),
        unpack( 1, 396 ),
        unpack( 1, 397 ),
        unpack( 1, 398 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 403 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 405 ),
        unpack( 1, 406 ),
        unpack( 1, 407 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 409 ),
        unpack( 1, 410 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 413 ),
        unpack(  ),
        unpack( 1, 414 ),
        unpack( 1, 415 ),
        unpack(  ),
        unpack( 1, 416 ),
        unpack( 1, 417 ),
        unpack( 1, 418 ),
        unpack( 1, 419 ),
        unpack( 1, 420 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 422 ),
        unpack( 1, 423 ),
        unpack( 1, 424 ),
        unpack( 1, 425 ),
        unpack( 1, 426 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 428 ),
        unpack( 1, 429 ),
        unpack( 1, 430 ),
        unpack( 1, 431 ),
        unpack( 1, 432 ),
        unpack( 1, 434, 16, -1, 1, 433 ),
        unpack( 1, 435 ),
        unpack( 1, 436 ),
        unpack( 1, 437 ),
        unpack( 1, 438 ),
        unpack( 1, 439 ),
        unpack( 1, 440 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 442 ),
        unpack( 1, 443 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 445 ),
        unpack( 1, 446 ),
        unpack( 1, 447 ),
        unpack( 1, 448 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 451 ),
        unpack( 1, 452 ),
        unpack( 1, 453 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 455 ),
        unpack(  ),
        unpack( 1, 456 ),
        unpack( 1, 457 ),
        unpack( 1, 458 ),
        unpack( 1, 459 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 462 ),
        unpack( 1, 463 ),
        unpack( 1, 464 ),
        unpack( 1, 465 ),
        unpack(  ),
        unpack( 1, 466 ),
        unpack(  ),
        unpack( 1, 467 ),
        unpack( 1, 468 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 472 ),
        unpack( 1, 473 ),
        unpack( 1, 474 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 476 ),
        unpack( 1, 477 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 479 ),
        unpack( 1, 480 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 482 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 484 ),
        unpack( 1, 485 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 488 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 490 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 493 ),
        unpack( 1, 494 ),
        unpack( 1, 495 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 497 ),
        unpack( 1, 498 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 500 ),
        unpack( 1, 501 ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 503 ),
        unpack( 1, 504 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 506 ),
        unpack( 1, 507 ),
        unpack(  ),
        unpack( 1, 508 ),
        unpack( 1, 509 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 511 ),
        unpack( 1, 512 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 514 ),
        unpack( 1, 515 ),
        unpack( 1, 516 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 519 ),
        unpack( 1, 520 ),
        unpack( 1, 521 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 522 ),
        unpack( 1, 523 ),
        unpack( 1, 524 ),
        unpack( 1, 525 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 528 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 529 ),
        unpack( 1, 530 ),
        unpack( 1, 531 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 533 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 8, 23, 1, 535, 17, 23, 4, 
                  -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 537 ),
        unpack(  ),
        unpack( 1, 538 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 540 ),
        unpack(  ),
        unpack( 1, 541 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 542 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 544 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 549 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 552 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 554 ),
        unpack(  ),
        unpack( 1, 555 ),
        unpack( 1, 556 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 560, 1, -1, 1, 559, 2, -1, 1, 558 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 564 ),
        unpack( 1, 565 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 569 ),
        unpack( 1, 570 ),
        unpack( 1, 571 ),
        unpack( 1, 572 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 574 ),
        unpack(  ),
        unpack( 1, 575 ),
        unpack( 1, 576 ),
        unpack(  ),
        unpack( 1, 577 ),
        unpack( 1, 578 ),
        unpack( 2, 23, 11, -1, 2, 23, 1, 579, 7, 23, 7, -1, 26, 23, 4, 
                  -1, 1, 23 ),
        unpack(  ),
        unpack( 1, 581 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 583 ),
        unpack(  ),
        unpack( 1, 584 ),
        unpack( 1, 585 ),
        unpack( 1, 586 ),
        unpack(  ),
        unpack( 1, 587 ),
        unpack( 1, 588 ),
        unpack( 1, 589 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 2, 23, 1, 591, 7, 23, 7, -1, 26, 23, 4, 
                  -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 595 ),
        unpack( 1, 596 ),
        unpack(  ),
        unpack( 1, 597 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 600 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 608 ),
        unpack( 1, 609 ),
        unpack( 1, 610 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 612 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 616 ),
        unpack( 1, 617 ),
        unpack( 1, 618 ),
        unpack(  ),
        unpack( 1, 619 ),
        unpack(  ),
        unpack(  ),
        unpack(  ),
        unpack( 1, 620 ),
        unpack( 1, 621 ),
        unpack( 1, 622 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 624 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 1, 626 ),
        unpack(  ),
        unpack( 1, 627 ),
        unpack(  ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack( 2, 23, 11, -1, 10, 23, 7, -1, 26, 23, 4, -1, 1, 23 ),
        unpack(  ),
        unpack(  )
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 14
      

      def description
        <<-'__dfa_description__'.strip!
          1:1: Tokens : ( T__50 | T__51 | T__52 | T__53 | T__54 | T__55 | T__56 | T__57 | T__58 | T__59 | T__60 | T__61 | T__62 | T__63 | T__64 | T__65 | T__66 | T__67 | T__68 | T__69 | T__70 | T__71 | T__72 | T__73 | T__74 | T__75 | T__76 | T__77 | T__78 | T__79 | T__80 | T__81 | T__82 | T__83 | T__84 | T__85 | T__86 | T__87 | T__88 | T__89 | T__90 | T__91 | T__92 | T__93 | T__94 | T__95 | T__96 | T__97 | T__98 | T__99 | T__100 | T__101 | T__102 | T__103 | T__104 | T__105 | T__106 | T__107 | T__108 | T__109 | T__110 | T__111 | T__112 | T__113 | T__114 | T__115 | T__116 | T__117 | T__118 | T__119 | T__120 | T__121 | T__122 | T__123 | T__124 | T__125 | T__126 | T__127 | T__128 | T__129 | T__130 | T__131 | T__132 | T__133 | T__134 | T__135 | T__136 | T__137 | T__138 | T__139 | T__140 | T__141 | T__142 | T__143 | T__144 | T__145 | T__146 | T__147 | T__148 | T__149 | T__150 | T__151 | T__152 | T__153 | T__154 | T__155 | T__156 | T__157 | T__158 | T__159 | T__160 | T__161 | T__162 | T__163 | T__164 | T__165 | T__166 | T__167 | QUOTED_STRING | ID | SEMI | COLON | DOUBLEDOT | DOT | COMMA | EXPONENT | ASTERISK | AT_SIGN | RPAREN | LPAREN | RBRACK | LBRACK | PLUS | MINUS | DIVIDE | EQ | PERCENTAGE | LLABEL | RLABEL | ASSIGN | ARROW | VERTBAR | DOUBLEVERTBAR | NOT_EQ | LTH | LEQ | GTH | GEQ | NUMBER | QUOTE | WS | SL_COMMENT | ML_COMMENT | TYPE_ATTR | ROWTYPE_ATTR | NOTFOUND_ATTR | FOUND_ATTR | ISOPEN_ATTR | ROWCOUNT_ATTR | BULK_ROWCOUNT_ATTR | CHARSET_ATTR );
        __dfa_description__
      end
    end

    
    private
    
    def initialize_dfas
      super rescue nil
      @dfa6 = DFA6.new( self, 6 ) do |s|
        case s
        when 0
          look_6_3 = @input.peek
          index_6_3 = @input.index
          @input.rewind( @input.last_marker, false )
          s = -1
          if ( look_6_3 == ?. ) and ( syntactic_predicate?( :synpred1_Plsql ) )
            s = 5
          elsif ( look_6_3.between?( ?0, ?9 ) )
            s = 3
          else
            s = 4
          end
           
          @input.seek( index_6_3 )

        when 1
          look_6_1 = @input.peek
          index_6_1 = @input.index
          @input.rewind( @input.last_marker, false )
          s = -1
          if ( look_6_1.between?( ?0, ?9 ) )
            s = 3
          elsif ( look_6_1 == ?. ) and ( syntactic_predicate?( :synpred1_Plsql ) )
            s = 5
          else
            s = 4
          end
           
          @input.seek( index_6_1 )

        end
        
        if s < 0
          @state.backtracking > 0 and raise ANTLR3::Error::BacktrackingFailed
          nva = ANTLR3::Error::NoViableAlternative.new( @dfa6.description, 6, s, input )
          @dfa6.error( nva )
          raise nva
        end
        
        s
      end
      @dfa14 = DFA14.new( self, 14 ) do |s|
        case s
        when 0
          look_14_22 = @input.peek
          s = -1
          if ( look_14_22.between?( 0x0000, 0xFFFF ) )
            s = 21
          else
            s = 116
          end

        end
        
        if s < 0
          @state.backtracking > 0 and raise ANTLR3::Error::BacktrackingFailed
          nva = ANTLR3::Error::NoViableAlternative.new( @dfa14.description, 14, s, input )
          @dfa14.error( nva )
          raise nva
        end
        
        s
      end

    end
  end # class Lexer < ANTLR3::Lexer

  at_exit { Lexer.main( ARGV ) } if __FILE__ == $0
end

