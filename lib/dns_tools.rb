require 'thor'
require 'resolv'

module DNSTools
  VERSION = '1.0.4'
  
  class Commands < Thor
  end
  
end

require 'dns_tools/ns_check'
