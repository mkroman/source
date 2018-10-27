#!/usr/bin/gem build
# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "source"
  spec.version = "1.0.2"
  spec.summary = "Source engine server query library."
  spec.homepage = "https://github.com/mkroman/source"

  spec.author  = "Mikkel Kroman"
  spec.email   = "mk@maero.dk"

  spec.files = Dir['library/**/*.rb', 'MIT.LICENSE', 'WTFPL.LICENSE']
  spec.bindir = "executables"
  spec.has_rdoc = true
  spec.require_path = "library"
  spec.required_ruby_version = ">= 1.9.1"
  spec.licenses = ['WTFPL', 'MIT']
end

# vim: set syntax=ruby:
