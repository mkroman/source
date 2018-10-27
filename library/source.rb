# encoding: utf-8

require 'socket'

require 'source/rcon'
require 'source/server'
require 'source/extensions'

module Source
  class << Version = [1,0,2]
    def to_s; join '.' end
  end
end
