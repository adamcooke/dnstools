$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'dns_tools'

Gem::Specification.new do |s|
  s.name = 'dnstools'
  s.version = DNSTools::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Set of DNS CLI Tools"
  s.files = Dir["**/*"]
  s.bindir = "bin"
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://atechmedia.com"
  s.executables << 'dnstools'
  s.add_dependency('thor', '>= 0.16.0')
end
