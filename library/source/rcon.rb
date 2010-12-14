# encoding: utf-8

module Source
  class RCON
    class ConnectionError < StandardError; end

    attr_accessor :host, :port

    ExecutionCommand = 2
    AuthenticationCommand = 3

    def self.for_server server
      new(server.host, server.port, server.pass).tap do |this|
        this.connect
      end
    end

    def initialize host, port = 27015, password = nil
      @host, @port, @pass, @id = host, port, password, 0
    end

    def connected?; @socket and not @socket.closed? end

    def connect
      raise ConnectionError, "Connection has already been established" if connected?

      @socket = TCPSocket.new @host, @port

      authenticate
    end

    def transmit command, key, value = ''
      raise ConnectionError, 'Connection has not been established' unless connected?

      String.new.tap do |buffer|
        buffer.<< [(@id += 1), command].pack 'VV'
        buffer << [key, ?\x00, value, ?\x00].join

        buffer.insert 0, [buffer.length].pack(?V)

        puts ">> #{buffer.inspect}"
        @socket.write buffer
      end
    end

  private

    def authenticate
      transmit AuthenticationCommand, @pass 

      puts "<< #{@socket.readpartial 4096}" # FIXME
    end
  end
end
