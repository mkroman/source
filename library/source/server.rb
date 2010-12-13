# encoding: utf-8

module Source
  class Server
    PingPacket = "\x69"
    InfoPacket = "TSource Engine Query\x00"

    def self.connect *args
      new(*args).tap do |this|
        this.connect
      end
    end

    def initialize host, port = 27015
      @host, @port = host, port

      @socket, @connected = UDPSocket.new, false
    end

    def connect
      @connected = true if not @connected and @socket.connect @host, @port
    end

    def transmit packet
      raise ConnectionError, 'Not connected to server' unless @connected

      @socket.send "\xFF\xFF\xFF\xFF#{packet}", 0
    end

    def read
      raise ConnectionError, 'Not connected to server' unless @connected

      response = @socket.recvfrom(1024)[0][4..-1]
    end

    def info
      raise ConnectionError, 'Not connected to server' unless @connected

      transmit InfoPacket
      response = read.unpack 'CCZ*Z*Z*Z*vc7Z*c'

      %w{type version name map game description appid players slots bots dedicated os password secure version EDF}.pair response
    end
  end
end
