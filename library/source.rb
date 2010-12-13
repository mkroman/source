# encoding: utf-8

require 'socket'

require 'source/server'
require 'source/extensions'

module Source
  class ConnectionError < StandardError; end

  class << Version = [1,0]
    def to_s; join '.' end
  end
end
