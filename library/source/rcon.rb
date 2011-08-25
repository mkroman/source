# encoding: utf-8
require 'socket'

module Source
  class RCON
    class ConnectionError < StandardError; end

    attr_accessor :host, :port

    AuthenticationCommand = "challenge rcon"

    def initialize host, port = 27015, password = nil
      @host, @port, @pass, @challenge = host, port, password, ""
    end

    def connected?; @socket and not @socket.closed? end

    def connect
      raise ConnectionError, "Connection has already been established" if connected?

      @socket = UDPSocket.new 

      authenticate
    end

    def transmit packet
      raise ConnectionError, 'Connection has not been established' unless connected?
      @socket.send "\xFF\xFF\xFF\xFF#{packet}", 0, @host, @port
    end

    def read
      @socket.readpartial 4096
    end

    def send command
      transmit "rcon #{@challenge} \"#{@pass}\" #{command}"
    end

    def authenticated?; @challenge end

    def authenticate
      transmit AuthenticationCommand

      challenge = @socket.readpartial 1024
      @challenge = challenge.gsub /[^\d+]/, ""
    end
  end
end
