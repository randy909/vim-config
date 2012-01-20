#!/usr/bin/env ruby
#
# Argument.g
# 
# Generated using ANTLR version: 3.2.1-SNAPSHOT Jun 18, 2010 05:38:11
# Ruby runtime library version: 1.7.4
# Input grammar file: Argument.g
# Generated at: 2010-07-19 16:33:28
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


module Argument
  # TokenData defines all of the token type integer values
  # as constants, which will be included in all 
  # ANTLR-generated recognizers.
  const_defined?( :TokenData ) or TokenData = ANTLR3::TokenScheme.new

  module TokenData

    # define the token constants
    define_tokens( :START_PROC => 9, :ML_COMMENT => 6, :EXPR => 11, :WS => 8, 
                    :DOUBLEQUOTED_STRING => 16, :PLSQL_MODULE => 10, :SL_COMMENT => 5, 
                    :QUOTED_STRING => 4, :END_FUNC => 15, :PARAM_DELIM => 13, 
                    :ID => 7, :EOF => -1, :CEXPR => 12, :START_ARGUMENT => 14 )
    
  end


  class Lexer < ANTLR3::Lexer
    @grammar_home = Argument
    include TokenData
    include ANTLR3::FilterMode

    
    begin
      generated_using( "Argument.g", "3.2.1-SNAPSHOT Jun 18, 2010 05:38:11", "1.7.4" )
    rescue NoMethodError => error
      # ignore
    end
    
    RULE_NAMES   = [ "QUOTED_STRING", "SL_COMMENT", "ML_COMMENT", "PLSQL_MODULE", 
                      "START_PROC", "CEXPR", "PARAM_DELIM", "EXPR", "START_ARGUMENT", 
                      "END_FUNC", "WS", "ID", "DOUBLEQUOTED_STRING" ].freeze
    RULE_METHODS = [ :quoted_string!, :sl_comment!, :ml_comment!, :plsql_module!, 
                      :start_proc!, :cexpr!, :param_delim!, :expr!, :start_argument!, 
                      :end_func!, :ws!, :id!, :doublequoted_string! ].freeze

    
    def initialize( input=nil, options = {} )
      super( input, options )
      # - - - - - - begin action @lexer::init - - - - - -
      # Argument.g


        @pmodules = []
        @open = false
        @stack = []
        @parent = -1

      # - - - - - - end action @lexer::init - - - - - - -

    end
    
    # - - - - - - begin action @lexer::members - - - - - -
    # Argument.g


      attr_reader :pmodules
      private
      ArgItem = Struct.new(:pos, :expr)

    # - - - - - - end action @lexer::members - - - - - - -

    
    # - - - - - - - - - - - lexer rules - - - - - - - - - - - -
    # lexer rule quoted_string! (QUOTED_STRING)
    # (in Argument.g)
    def quoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 1 )

      type = QUOTED_STRING
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 22:5: ( 'n' )? '\\'' ( '\\'\\'' | ~ ( '\\'' ) )* '\\''
      # at line 22:5: ( 'n' )?
      alt_1 = 2
      look_1_0 = @input.peek( 1 )

      if ( look_1_0 == ?n )
        alt_1 = 1
      end
      case alt_1
      when 1
        # at line 22:7: 'n'
        match( ?n )

      end
      match( ?\' )
      # at line 22:19: ( '\\'\\'' | ~ ( '\\'' ) )*
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
          # at line 22:21: '\\'\\''
          match( "''" )

        when 2
          # at line 22:30: ~ ( '\\'' )
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
      # trace_out( __method__, 1 )

    end

    # lexer rule sl_comment! (SL_COMMENT)
    # (in Argument.g)
    def sl_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 2 )

      type = SL_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 26:5: '--' (~ ( '\\n' | '\\r' ) )* ( '\\r' )? '\\n'
      match( "--" )
      # at line 26:10: (~ ( '\\n' | '\\r' ) )*
      while true # decision 3
        alt_3 = 2
        look_3_0 = @input.peek( 1 )

        if ( look_3_0.between?( 0x0000, ?\t ) || look_3_0.between?( 0x000B, ?\f ) || look_3_0.between?( 0x000E, 0xFFFF ) )
          alt_3 = 1

        end
        case alt_3
        when 1
          # at line 26:10: ~ ( '\\n' | '\\r' )
          if @input.peek( 1 ).between?( 0x0000, ?\t ) || @input.peek( 1 ).between?( 0x000B, ?\f ) || @input.peek( 1 ).between?( 0x000E, 0x00FF )
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
      # at line 26:24: ( '\\r' )?
      alt_4 = 2
      look_4_0 = @input.peek( 1 )

      if ( look_4_0 == ?\r )
        alt_4 = 1
      end
      case alt_4
      when 1
        # at line 26:24: '\\r'
        match( ?\r )

      end
      match( ?\n )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 2 )

    end

    # lexer rule ml_comment! (ML_COMMENT)
    # (in Argument.g)
    def ml_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 3 )

      type = ML_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 30:5: '/*' ( options {greedy=false; } : . )* '*/'
      match( "/*" )
      # at line 30:10: ( options {greedy=false; } : . )*
      while true # decision 5
        alt_5 = 2
        look_5_0 = @input.peek( 1 )

        if ( look_5_0 == ?* )
          look_5_1 = @input.peek( 2 )

          if ( look_5_1 == ?/ )
            alt_5 = 2
          elsif ( look_5_1.between?( 0x0000, ?. ) || look_5_1.between?( ?0, 0xFFFF ) )
            alt_5 = 1

          end
        elsif ( look_5_0.between?( 0x0000, ?) ) || look_5_0.between?( ?+, 0xFFFF ) )
          alt_5 = 1

        end
        case alt_5
        when 1
          # at line 30:38: .
          match_any

        else
          break # out of loop for decision 5
        end
      end # loop for decision 5
      match( "*/" )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 3 )

    end

    # lexer rule plsql_module! (PLSQL_MODULE)
    # (in Argument.g)
    def plsql_module!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 4 )

      type = PLSQL_MODULE
      channel = ANTLR3::DEFAULT_CHANNEL
      # - - - - label initialization - - - -
      tk1 = nil
      tk2 = nil
      tk3 = nil
      p = nil
      __ID1__ = nil


      
      # - - - - main rule block - - - -
      # at line 34:3: ( (tk1= ID '.' tk2= ID '.' tk3= ID ( WS )? p= START_PROC ) | (tk1= ID '.' tk2= ID ( WS )? p= START_PROC ) | ( ID ( WS )? p= START_PROC ) )
      alt_9 = 3
      alt_9 = @dfa9.predict( @input )
      case alt_9
      when 1
        # at line 34:5: (tk1= ID '.' tk2= ID '.' tk3= ID ( WS )? p= START_PROC )
        # at line 34:5: (tk1= ID '.' tk2= ID '.' tk3= ID ( WS )? p= START_PROC )
        # at line 34:6: tk1= ID '.' tk2= ID '.' tk3= ID ( WS )? p= START_PROC
        tk1_start_147 = self.character_index
        id!
        tk1 = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = tk1_start_147
          t.stop    = self.character_index - 1
        end
        match( ?. )
        tk2_start_153 = self.character_index
        id!
        tk2 = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = tk2_start_153
          t.stop    = self.character_index - 1
        end
        match( ?. )
        tk3_start_159 = self.character_index
        id!
        tk3 = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = tk3_start_159
          t.stop    = self.character_index - 1
        end
        # at line 34:35: ( WS )?
        alt_6 = 2
        look_6_0 = @input.peek( 1 )

        if ( look_6_0.between?( ?\t, ?\n ) || look_6_0 == ?\s )
          alt_6 = 1
        end
        case alt_6
        when 1
          # at line 34:35: WS
          ws!

        end
        p_start_166 = self.character_index
        start_proc!
        p = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = p_start_166
          t.stop    = self.character_index - 1
        end

        # syntactic predicate action gate test
        if @state.backtracking == 1
          # --> action
           @pmodules << {:name => tk1.text + '.' + tk2.text + '.' + tk3.text, :args => [ArgItem.new(p.start + 1 .. p.stop + 1, nil)] } ; @parent += 1 
          # <-- action
        end

      when 2
        # at line 36:5: (tk1= ID '.' tk2= ID ( WS )? p= START_PROC )
        # at line 36:5: (tk1= ID '.' tk2= ID ( WS )? p= START_PROC )
        # at line 36:6: tk1= ID '.' tk2= ID ( WS )? p= START_PROC
        tk1_start_180 = self.character_index
        id!
        tk1 = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = tk1_start_180
          t.stop    = self.character_index - 1
        end
        match( ?. )
        tk2_start_186 = self.character_index
        id!
        tk2 = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = tk2_start_186
          t.stop    = self.character_index - 1
        end
        # at line 36:24: ( WS )?
        alt_7 = 2
        look_7_0 = @input.peek( 1 )

        if ( look_7_0.between?( ?\t, ?\n ) || look_7_0 == ?\s )
          alt_7 = 1
        end
        case alt_7
        when 1
          # at line 36:24: WS
          ws!

        end
        p_start_193 = self.character_index
        start_proc!
        p = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = p_start_193
          t.stop    = self.character_index - 1
        end

        # syntactic predicate action gate test
        if @state.backtracking == 1
          # --> action
           @pmodules << {:name => tk1.text + '.' + tk2.text, :args => [ArgItem.new(p.start + 1 .. (p.stop + 1), nil)] } ; @parent += 1 
          # <-- action
        end

      when 3
        # at line 38:5: ( ID ( WS )? p= START_PROC )
        # at line 38:5: ( ID ( WS )? p= START_PROC )
        # at line 38:6: ID ( WS )? p= START_PROC
        __ID1___start_205 = self.character_index
        id!
        __ID1__ = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = __ID1___start_205
          t.stop    = self.character_index - 1
        end
        # at line 38:9: ( WS )?
        alt_8 = 2
        look_8_0 = @input.peek( 1 )

        if ( look_8_0.between?( ?\t, ?\n ) || look_8_0 == ?\s )
          alt_8 = 1
        end
        case alt_8
        when 1
          # at line 38:9: WS
          ws!

        end
        p_start_212 = self.character_index
        start_proc!
        p = create_token do |t|
          t.input   = @input
          t.type    = ANTLR3::INVALID_TOKEN_TYPE
          t.channel = ANTLR3::DEFAULT_CHANNEL
          t.start   = p_start_212
          t.stop    = self.character_index - 1
        end

        # syntactic predicate action gate test
        if @state.backtracking == 1
          # --> action
           @pmodules << {:name => __ID1__.text, :args => [ArgItem.new(p.start + 1 .. (p.stop + 1), nil)] } ; @parent += 1
          # <-- action
        end

      end
      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 4 )

    end

    # lexer rule start_proc! (START_PROC)
    # (in Argument.g)
    def start_proc!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 5 )

      
      # - - - - main rule block - - - -
      # at line 44:5: '(' ( WS )?
      match( ?( )
      # at line 44:9: ( WS )?
      alt_10 = 2
      look_10_0 = @input.peek( 1 )

      if ( look_10_0.between?( ?\t, ?\n ) || look_10_0 == ?\s )
        alt_10 = 1
      end
      case alt_10
      when 1
        # at line 44:9: WS
        ws!

      end

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 5 )

    end

    # lexer rule cexpr! (CEXPR)
    # (in Argument.g)
    def cexpr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 6 )

      type = CEXPR
      channel = ANTLR3::DEFAULT_CHANNEL
      # - - - - label initialization - - - -
      tk = nil


      
      # - - - - main rule block - - - -
      # at line 48:5: tk= EXPR
      tk_start_250 = self.character_index
      expr!
      tk = create_token do |t|
        t.input   = @input
        t.type    = ANTLR3::INVALID_TOKEN_TYPE
        t.channel = ANTLR3::DEFAULT_CHANNEL
        t.start   = tk_start_250
        t.stop    = self.character_index - 1
      end
      # syntactic predicate action gate test
      if @state.backtracking == 1
        # --> action
         @pmodules[@parent][:args] << ArgItem.new(tk.start .. tk.stop, tk.text) if @parent >= 0 
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 6 )

    end

    # lexer rule param_delim! (PARAM_DELIM)
    # (in Argument.g)
    def param_delim!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 7 )

      
      # - - - - main rule block - - - -
      # at line 53:5: ',' ( WS )?
      match( ?, )
      # at line 53:9: ( WS )?
      alt_11 = 2
      look_11_0 = @input.peek( 1 )

      if ( look_11_0.between?( ?\t, ?\n ) || look_11_0 == ?\s )
        alt_11 = 1
      end
      case alt_11
      when 1
        # at line 53:9: WS
        ws!

      end

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 7 )

    end

    # lexer rule expr! (EXPR)
    # (in Argument.g)
    def expr!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 8 )

      
      # - - - - main rule block - - - -
      # at line 58:5: '(' ( EXPR | ~ ( ')' ) )* ')'
      match( ?( )
      # at line 58:9: ( EXPR | ~ ( ')' ) )*
      while true # decision 12
        alt_12 = 3
        look_12_0 = @input.peek( 1 )

        if ( look_12_0 == ?( )
          alt_12 = 1
        elsif ( look_12_0.between?( 0x0000, ?\' ) || look_12_0.between?( ?*, 0xFFFF ) )
          alt_12 = 2

        end
        case alt_12
        when 1
          # at line 58:11: EXPR
          expr!

        when 2
          # at line 58:18: ~ ( ')' )
          if @input.peek( 1 ).between?( 0x0000, ?( ) || @input.peek( 1 ).between?( ?*, 0x00FF )
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          break # out of loop for decision 12
        end
      end # loop for decision 12
      match( ?) )

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 8 )

    end

    # lexer rule start_argument! (START_ARGUMENT)
    # (in Argument.g)
    def start_argument!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 9 )

      type = START_ARGUMENT
      channel = ANTLR3::DEFAULT_CHANNEL
      # - - - - label initialization - - - -
      p = nil


      
      # - - - - main rule block - - - -
      # at line 62:5: p= PARAM_DELIM
      p_start_318 = self.character_index
      param_delim!
      p = create_token do |t|
        t.input   = @input
        t.type    = ANTLR3::INVALID_TOKEN_TYPE
        t.channel = ANTLR3::DEFAULT_CHANNEL
        t.start   = p_start_318
        t.stop    = self.character_index - 1
      end
      # syntactic predicate action gate test
      if @state.backtracking == 1
        # --> action
         @pmodules[@parent][:args] << ArgItem.new(p.start + 1 .. (p.stop + 1), nil) if @parent >= 0 
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 9 )

    end

    # lexer rule end_func! (END_FUNC)
    # (in Argument.g)
    def end_func!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 10 )

      type = END_FUNC
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 67:5: ')'
      match( ?) )
      # syntactic predicate action gate test
      if @state.backtracking == 1
        # --> action
         @parent -= 1 if @parent > 0 
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 10 )

    end

    # lexer rule ws! (WS)
    # (in Argument.g)
    def ws!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 11 )

      type = WS
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 71:5: ( ' ' | '\\t' | '\\n' )+
      # at file 71:5: ( ' ' | '\\t' | '\\n' )+
      match_count_13 = 0
      while true
        alt_13 = 2
        look_13_0 = @input.peek( 1 )

        if ( look_13_0.between?( ?\t, ?\n ) || look_13_0 == ?\s )
          alt_13 = 1

        end
        case alt_13
        when 1
          # at line 
          if @input.peek( 1 ).between?( ?\t, ?\n ) || @input.peek(1) == ?\s
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          match_count_13 > 0 and break
          @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

          eee = EarlyExit(13)


          raise eee
        end
        match_count_13 += 1
      end


      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 11 )

    end

    # lexer rule id! (ID)
    # (in Argument.g)
    def id!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 12 )

      
      # - - - - main rule block - - - -
      # at line 76:5: ( 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )* | DOUBLEQUOTED_STRING )
      alt_15 = 2
      look_15_0 = @input.peek( 1 )

      if ( look_15_0.between?( ?A, ?Z ) )
        alt_15 = 1
      elsif ( look_15_0 == ?" )
        alt_15 = 2
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 15, 0 )
      end
      case alt_15
      when 1
        # at line 76:7: 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        match_range( ?A, ?Z )
        # at line 76:18: ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        while true # decision 14
          alt_14 = 2
          look_14_0 = @input.peek( 1 )

          if ( look_14_0.between?( ?#, ?$ ) || look_14_0.between?( ?0, ?9 ) || look_14_0.between?( ?A, ?Z ) || look_14_0 == ?_ )
            alt_14 = 1

          end
          case alt_14
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
            break # out of loop for decision 14
          end
        end # loop for decision 14

      when 2
        # at line 77:7: DOUBLEQUOTED_STRING
        doublequoted_string!

      end
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 12 )

    end

    # lexer rule doublequoted_string! (DOUBLEQUOTED_STRING)
    # (in Argument.g)
    def doublequoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 13 )

      
      # - - - - main rule block - - - -
      # at line 82:5: '\"' (~ ( '\"' ) )* '\"'
      match( ?" )
      # at line 82:9: (~ ( '\"' ) )*
      while true # decision 16
        alt_16 = 2
        look_16_0 = @input.peek( 1 )

        if ( look_16_0.between?( 0x0000, ?! ) || look_16_0.between?( ?#, 0xFFFF ) )
          alt_16 = 1

        end
        case alt_16
        when 1
          # at line 82:11: ~ ( '\"' )
          if @input.peek( 1 ).between?( 0x0000, ?! ) || @input.peek( 1 ).between?( ?#, 0x00FF )
            @input.consume
          else
            @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

            mse = MismatchedSet( nil )
            recover mse
            raise mse
          end



        else
          break # out of loop for decision 16
        end
      end # loop for decision 16
      match( ?" )

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 13 )

    end

    # main rule used to study the input at the current position,
    # and choose the proper lexer rule to call in order to
    # fetch the next token
    # 
    # usually, you don't make direct calls to this method,
    # but instead use the next_token method, which will
    # build and emit the actual next token
    def token!
      # at line 1:39: ( QUOTED_STRING | SL_COMMENT | ML_COMMENT | PLSQL_MODULE | CEXPR | START_ARGUMENT | END_FUNC | WS )
      alt_17 = 8
      case look_17 = @input.peek( 1 )
      when ?\', ?n then alt_17 = 1
      when ?- then alt_17 = 2
      when ?/ then alt_17 = 3
      when ?", ?A, ?B, ?C, ?D, ?E, ?F, ?G, ?H, ?I, ?J, ?K, ?L, ?M, ?N, ?O, ?P, ?Q, ?R, ?S, ?T, ?U, ?V, ?W, ?X, ?Y, ?Z then alt_17 = 4
      when ?( then alt_17 = 5
      when ?, then alt_17 = 6
      when ?) then alt_17 = 7
      when ?\t, ?\n, ?\s then alt_17 = 8
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 17, 0 )
      end
      case alt_17
      when 1
        # at line 1:41: QUOTED_STRING
        quoted_string!

      when 2
        # at line 1:55: SL_COMMENT
        sl_comment!

      when 3
        # at line 1:66: ML_COMMENT
        ml_comment!

      when 4
        # at line 1:77: PLSQL_MODULE
        plsql_module!

      when 5
        # at line 1:90: CEXPR
        cexpr!

      when 6
        # at line 1:96: START_ARGUMENT
        start_argument!

      when 7
        # at line 1:111: END_FUNC
        end_func!

      when 8
        # at line 1:120: WS
        ws!

      end
    end

    
    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA9 < ANTLR3::DFA
      EOT = unpack( 15, -1 )
      EOF = unpack( 15, -1 )
      MIN = unpack( 1, 34, 1, 9, 1, 0, 1, 9, 1, 34, 1, -1, 1, 0, 2, 9, 
                     1, 0, 1, 9, 2, -1, 1, 0, 1, 9 )
      MAX = unpack( 1, 90, 1, 95, 1, -1, 1, 95, 1, 90, 1, -1, 1, -1, 1, 
                     46, 1, 95, 1, -1, 1, 95, 2, -1, 1, -1, 1, 46 )
      ACCEPT = unpack( 5, -1, 1, 3, 5, -1, 1, 2, 1, 1, 2, -1 )
      SPECIAL = unpack( 2, -1, 1, 1, 3, -1, 1, 2, 2, -1, 1, 0, 3, -1, 1, 
                         3, 1, -1 )
      TRANSITION = [
        unpack( 1, 2, 30, -1, 26, 1 ),
        unpack( 2, 5, 21, -1, 1, 5, 2, -1, 2, 3, 3, -1, 1, 5, 5, -1, 1, 
                  4, 1, -1, 10, 3, 7, -1, 26, 3, 4, -1, 1, 3 ),
        unpack( 34, 6, 1, 7, 65501, 6 ),
        unpack( 2, 5, 21, -1, 1, 5, 2, -1, 2, 3, 3, -1, 1, 5, 5, -1, 1, 
                  4, 1, -1, 10, 3, 7, -1, 26, 3, 4, -1, 1, 3 ),
        unpack( 1, 9, 30, -1, 26, 8 ),
        unpack(  ),
        unpack( 34, 6, 1, 7, 65501, 6 ),
        unpack( 2, 5, 21, -1, 1, 5, 7, -1, 1, 5, 5, -1, 1, 4 ),
        unpack( 2, 11, 21, -1, 1, 11, 2, -1, 2, 10, 3, -1, 1, 11, 5, -1, 
                  1, 12, 1, -1, 10, 10, 7, -1, 26, 10, 4, -1, 1, 10 ),
        unpack( 34, 13, 1, 14, 65501, 13 ),
        unpack( 2, 11, 21, -1, 1, 11, 2, -1, 2, 10, 3, -1, 1, 11, 5, -1, 
                  1, 12, 1, -1, 10, 10, 7, -1, 26, 10, 4, -1, 1, 10 ),
        unpack(  ),
        unpack(  ),
        unpack( 34, 13, 1, 14, 65501, 13 ),
        unpack( 2, 11, 21, -1, 1, 11, 7, -1, 1, 11, 5, -1, 1, 12 )
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 9
      

      def description
        <<-'__dfa_description__'.strip!
          33:1: PLSQL_MODULE : ( (tk1= ID '.' tk2= ID '.' tk3= ID ( WS )? p= START_PROC ) | (tk1= ID '.' tk2= ID ( WS )? p= START_PROC ) | ( ID ( WS )? p= START_PROC ) );
        __dfa_description__
      end
    end

    
    private
    
    def initialize_dfas
      super rescue nil
      @dfa9 = DFA9.new( self, 9 ) do |s|
        case s
        when 0
          look_9_9 = @input.peek
          s = -1
          if ( look_9_9.between?( 0x0000, ?! ) || look_9_9.between?( ?#, 0xFFFF ) )
            s = 13
          elsif ( look_9_9 == ?" )
            s = 14
          end

        when 1
          look_9_2 = @input.peek
          s = -1
          if ( look_9_2.between?( 0x0000, ?! ) || look_9_2.between?( ?#, 0xFFFF ) )
            s = 6
          elsif ( look_9_2 == ?" )
            s = 7
          end

        when 2
          look_9_6 = @input.peek
          s = -1
          if ( look_9_6 == ?" )
            s = 7
          elsif ( look_9_6.between?( 0x0000, ?! ) || look_9_6.between?( ?#, 0xFFFF ) )
            s = 6
          end

        when 3
          look_9_13 = @input.peek
          s = -1
          if ( look_9_13 == ?" )
            s = 14
          elsif ( look_9_13.between?( 0x0000, ?! ) || look_9_13.between?( ?#, 0xFFFF ) )
            s = 13
          end

        end
        
        if s < 0
          @state.backtracking > 0 and raise ANTLR3::Error::BacktrackingFailed
          nva = ANTLR3::Error::NoViableAlternative.new( @dfa9.description, 9, s, input )
          @dfa9.error( nva )
          raise nva
        end
        
        s
      end

    end
  end # class Lexer < ANTLR3::Lexer

  at_exit { Lexer.main( ARGV ) } if __FILE__ == $0
end

