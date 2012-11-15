require 'thor'
require 'resolv'

module DNSTools
  VERSION = '1.0.3'
  
  class Commands < Thor
  end
  
end

require 'dns_tools/serial_check'
