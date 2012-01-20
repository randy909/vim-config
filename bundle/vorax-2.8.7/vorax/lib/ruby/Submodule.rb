#!/usr/bin/env ruby
#
# Submodule.g
# 
# Generated using ANTLR version: 3.2.1-SNAPSHOT Jun 18, 2010 05:38:11
# Ruby runtime library version: 1.7.4
# Input grammar file: Submodule.g
# Generated at: 2010-07-27 16:11:10
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


module Submodule
  # TokenData defines all of the token type integer values
  # as constants, which will be included in all 
  # ANTLR-generated recognizers.
  const_defined?( :TokenData ) or TokenData = ANTLR3::TokenScheme.new

  module TokenData

    # define the token constants
    define_tokens( :ML_COMMENT => 10, :WS => 4, :SUBMODULE => 7, :DOUBLEQUOTED_STRING => 12, 
                    :SL_COMMENT => 9, :QUOTED_STRING => 8, :SUBMODULE_NAME => 6, 
                    :ID => 11, :EOF => -1, :SUBMODULE_TYPE => 5 )
    
  end


  class Lexer < ANTLR3::Lexer
    @grammar_home = Submodule
    include TokenData
    include ANTLR3::FilterMode

    
    begin
      generated_using( "Submodule.g", "3.2.1-SNAPSHOT Jun 18, 2010 05:38:11", "1.7.4" )
    rescue NoMethodError => error
      # ignore
    end
    
    RULE_NAMES   = [ "SUBMODULE", "QUOTED_STRING", "SL_COMMENT", "ML_COMMENT", 
                      "WS", "SUBMODULE_NAME", "SUBMODULE_TYPE", "ID", "DOUBLEQUOTED_STRING" ].freeze
    RULE_METHODS = [ :submodule!, :quoted_string!, :sl_comment!, :ml_comment!, 
                      :ws!, :submodule_name!, :submodule_type!, :id!, :doublequoted_string! ].freeze

    
    def initialize( input=nil, options = {} )
      super( input, options )
      # - - - - - - begin action @lexer::init - - - - - -
      # Submodule.g


        @oracle_submodules = []

      # - - - - - - end action @lexer::init - - - - - - -

    end
    
    # - - - - - - begin action @lexer::members - - - - - -
    # Submodule.g



      attr_reader :oracle_submodules

      private

      def add_entry(tk, type)
        @object_name.gsub!(/\"/, '') if @object_name
        pos = tk.start
        lines = self.input.data[ 0 .. pos ]
        @oracle_submodules << { :object => @object_name, :type => type, :start_line => lines.split(/\n/).length }
        @object_name = nil
      end


    # - - - - - - end action @lexer::members - - - - - - -

    
    # - - - - - - - - - - - lexer rules - - - - - - - - - - - -
    # lexer rule submodule! (SUBMODULE)
    # (in Submodule.g)
    def submodule!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 1 )

      type = SUBMODULE
      channel = ANTLR3::DEFAULT_CHANNEL
      # - - - - label initialization - - - -
      tk = nil


      
      # - - - - main rule block - - - -
      # at line 29:5: WS tk= SUBMODULE_TYPE WS SUBMODULE_NAME
      ws!
      tk_start_49 = self.character_index
      submodule_type!
      tk = create_token do |t|
        t.input   = @input
        t.type    = ANTLR3::INVALID_TOKEN_TYPE
        t.channel = ANTLR3::DEFAULT_CHANNEL
        t.start   = tk_start_49
        t.stop    = self.character_index - 1
      end
      ws!
      submodule_name!
      # syntactic predicate action gate test
      if @state.backtracking == 1
        # --> action

            add_entry(tk, tk.text)
          
        # <-- action
      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 1 )

    end

    # lexer rule quoted_string! (QUOTED_STRING)
    # (in Submodule.g)
    def quoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 2 )

      type = QUOTED_STRING
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 36:5: ( 'n' )? '\\'' ( '\\'\\'' | ~ ( '\\'' ) )* '\\''
      # at line 36:5: ( 'n' )?
      alt_1 = 2
      look_1_0 = @input.peek( 1 )

      if ( look_1_0 == ?n )
        alt_1 = 1
      end
      case alt_1
      when 1
        # at line 36:7: 'n'
        match( ?n )

      end
      match( ?\' )
      # at line 36:19: ( '\\'\\'' | ~ ( '\\'' ) )*
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
          # at line 36:21: '\\'\\''
          match( "''" )

        when 2
          # at line 36:30: ~ ( '\\'' )
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
      # trace_out( __method__, 2 )

    end

    # lexer rule sl_comment! (SL_COMMENT)
    # (in Submodule.g)
    def sl_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 3 )

      type = SL_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 40:5: '--' (~ ( '\\n' | '\\r' ) )* ( '\\r' )? '\\n'
      match( "--" )
      # at line 40:10: (~ ( '\\n' | '\\r' ) )*
      while true # decision 3
        alt_3 = 2
        look_3_0 = @input.peek( 1 )

        if ( look_3_0.between?( 0x0000, ?\t ) || look_3_0.between?( 0x000B, ?\f ) || look_3_0.between?( 0x000E, 0xFFFF ) )
          alt_3 = 1

        end
        case alt_3
        when 1
          # at line 40:10: ~ ( '\\n' | '\\r' )
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
      # at line 40:24: ( '\\r' )?
      alt_4 = 2
      look_4_0 = @input.peek( 1 )

      if ( look_4_0 == ?\r )
        alt_4 = 1
      end
      case alt_4
      when 1
        # at line 40:24: '\\r'
        match( ?\r )

      end
      match( ?\n )

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 3 )

    end

    # lexer rule ml_comment! (ML_COMMENT)
    # (in Submodule.g)
    def ml_comment!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 4 )

      type = ML_COMMENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 44:5: '/*' ( options {greedy=false; } : . )* '*/'
      match( "/*" )
      # at line 44:10: ( options {greedy=false; } : . )*
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
          # at line 44:38: .
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
      # trace_out( __method__, 4 )

    end

    # lexer rule ws! (WS)
    # (in Submodule.g)
    def ws!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 5 )

      
      # - - - - main rule block - - - -
      # at line 49:5: ( ' ' | '\\t' | '\\n' )+
      # at file 49:5: ( ' ' | '\\t' | '\\n' )+
      match_count_6 = 0
      while true
        alt_6 = 2
        look_6_0 = @input.peek( 1 )

        if ( look_6_0.between?( ?\t, ?\n ) || look_6_0 == ?\s )
          alt_6 = 1

        end
        case alt_6
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
          match_count_6 > 0 and break
          @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

          eee = EarlyExit(6)


          raise eee
        end
        match_count_6 += 1
      end


    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 5 )

    end

    # lexer rule submodule_name! (SUBMODULE_NAME)
    # (in Submodule.g)
    def submodule_name!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 6 )
      # - - - - label initialization - - - -
      object = nil


      
      # - - - - main rule block - - - -
      # at line 54:5: object= ID
      object_start_197 = self.character_index
      id!
      object = create_token do |t|
        t.input   = @input
        t.type    = ANTLR3::INVALID_TOKEN_TYPE
        t.channel = ANTLR3::DEFAULT_CHANNEL
        t.start   = object_start_197
        t.stop    = self.character_index - 1
      end
      # syntactic predicate action gate test
      if @state.backtracking == 1
        # --> action
         @object_name = object.text if object 
        # <-- action
      end

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 6 )

    end

    # lexer rule submodule_type! (SUBMODULE_TYPE)
    # (in Submodule.g)
    def submodule_type!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 7 )

      
      # - - - - main rule block - - - -
      # at line 59:3: ( 'PROCEDURE' | 'FUNCTION' )
      alt_7 = 2
      look_7_0 = @input.peek( 1 )

      if ( look_7_0 == ?P )
        alt_7 = 1
      elsif ( look_7_0 == ?F )
        alt_7 = 2
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 7, 0 )
      end
      case alt_7
      when 1
        # at line 59:5: 'PROCEDURE'
        match( "PROCEDURE" )

      when 2
        # at line 60:5: 'FUNCTION'
        match( "FUNCTION" )

      end
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 7 )

    end

    # lexer rule id! (ID)
    # (in Submodule.g)
    def id!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 8 )

      
      # - - - - main rule block - - - -
      # at line 65:5: ( 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )* | DOUBLEQUOTED_STRING )
      alt_9 = 2
      look_9_0 = @input.peek( 1 )

      if ( look_9_0.between?( ?A, ?Z ) )
        alt_9 = 1
      elsif ( look_9_0 == ?" )
        alt_9 = 2
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 9, 0 )
      end
      case alt_9
      when 1
        # at line 65:7: 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        match_range( ?A, ?Z )
        # at line 65:18: ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
        while true # decision 8
          alt_8 = 2
          look_8_0 = @input.peek( 1 )

          if ( look_8_0.between?( ?#, ?$ ) || look_8_0.between?( ?0, ?9 ) || look_8_0.between?( ?A, ?Z ) || look_8_0 == ?_ )
            alt_8 = 1

          end
          case alt_8
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
            break # out of loop for decision 8
          end
        end # loop for decision 8

      when 2
        # at line 66:7: DOUBLEQUOTED_STRING
        doublequoted_string!

      end
    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out( __method__, 8 )

    end

    # lexer rule doublequoted_string! (DOUBLEQUOTED_STRING)
    # (in Submodule.g)
    def doublequoted_string!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in( __method__, 9 )

      
      # - - - - main rule block - - - -
      # at line 71:5: '\"' (~ ( '\"' ) )* '\"'
      match( ?" )
      # at line 71:9: (~ ( '\"' ) )*
      while true # decision 10
        alt_10 = 2
        look_10_0 = @input.peek( 1 )

        if ( look_10_0.between?( 0x0000, ?! ) || look_10_0.between?( ?#, 0xFFFF ) )
          alt_10 = 1

        end
        case alt_10
        when 1
          # at line 71:11: ~ ( '\"' )
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
      # trace_out( __method__, 9 )

    end

    # main rule used to study the input at the current position,
    # and choose the proper lexer rule to call in order to
    # fetch the next token
    # 
    # usually, you don't make direct calls to this method,
    # but instead use the next_token method, which will
    # build and emit the actual next token
    def token!
      # at line 1:39: ( SUBMODULE | QUOTED_STRING | SL_COMMENT | ML_COMMENT )
      alt_11 = 4
      case look_11 = @input.peek( 1 )
      when ?\t, ?\n, ?\s then alt_11 = 1
      when ?\', ?n then alt_11 = 2
      when ?- then alt_11 = 3
      when ?/ then alt_11 = 4
      else
        @state.backtracking > 0 and raise( ANTLR3::Error::BacktrackingFailed )

        raise NoViableAlternative( "", 11, 0 )
      end
      case alt_11
      when 1
        # at line 1:41: SUBMODULE
        submodule!

      when 2
        # at line 1:51: QUOTED_STRING
        quoted_string!

      when 3
        # at line 1:65: SL_COMMENT
        sl_comment!

      when 4
        # at line 1:76: ML_COMMENT
        ml_comment!

      end
    end

  end # class Lexer < ANTLR3::Lexer

  at_exit { Lexer.main( ARGV ) } if __FILE__ == $0
end

