#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'source'

puts "=> Source #{Source::Version}"
puts

server = Source::Server.connect 'maero.dk', 27015, 'ingenveddet'
server.rcon

info = server.info

puts '-' * info["name"].length
puts info["name"]
puts '-' * info["name"].length
puts

info.each do |key, value|
  puts "#{key.ljust info.keys.map(&:length).max + 1}: #{value}"
end
