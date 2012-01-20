require 'stringio'

class AliasResolver

  def self.columns_for(stmt, cpos, prefix)
    cols = []
    #text = stmt[cpos..-1]
    text = stmt.upcase
    prefix.upcase!
    sources = Alias::Lexer::gather_for(text, 0)
    # is the prefix a simple word?
    if prefix =~ /^[A-Z0-9$#_]+$/
      # it could be an alias... is it?
      a = sources.find { |src| src.idn && src.idn == prefix }
      if a && a.expr
        #get subselect columns
        collect_columns(a.object, sources, 1, cols)
      elsif a
        cols << "#{a.owner=="" ? "" : a.owner + "."}#{a.object}.*"
      else
        cols << "#{prefix}.*"
      end
    end
    cols
  end

  private

  def self.collect_columns(stmt, sources, level, columns)
    text = stmt.upcase
    lexer = Plsql::Lexer.new(text)
    tokens = ANTLR3::CommonTokenStream.new(lexer)
    parser = Plsql::Parser.new(tokens, :error_output => StringIO.new)
    begin
      result = parser.select_command
    rescue
      # ignore errors
    end
    parser.columns.each do |col|
      if col =~ /^[A-Z0-9$#_]+$/
        columns << col
      elsif col =~ /^[A-Z0-9]+\.\*$/
        # find aliases
        a = sources.find { |als| als.idn == col.split('.')[0] && als.level == level }
        if a.expr
          collect_columns(a.object, sources, level+1, columns)
        else
          columns << "#{a.object}.*"
        end
      elsif col == '*'
        lvlsrc = sources.find_all { |e| e.level == level }
        lvlsrc.each do |src|
          if src.expr
            collect_columns(src.object, sources, level+1, columns)
          else
            columns << "#{src.owner=="" ? "" : src.owner + "."}#{src.object}.*"
          end
        end
      end
    end
  end

end


