require 'pty'

$VERBOSE=nil

class UnixPIO

  BUF_SIZE = 32767

  attr_reader :pid

  def initialize(command)
    @reader, @writer, @pid = PTY.spawn(command)
    @writer.sync = true
    @reader.sync = true
  end

  def write(text)
    @writer.puts(text)
  end

  def read
    buf = ""
    begin
      while c = @reader.read_nonblock(1000)
        buf << c if c
        return buf if buf.length == BUF_SIZE
      end
    rescue
    end
    buf
  end

end

