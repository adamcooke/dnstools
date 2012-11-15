module DNSTools
  class Commands
    
    desc "serialcheck example.com", "Checks the serial number for all a domain's nameservers is the same on all records"
    def serialcheck(domain)
      root_resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8'])

      nameservers = root_resolver.getresources(domain, Resolv::DNS::Resource::IN::NS)
      serials = []

      for ns in nameservers
        ns_resolver = Resolv::DNS.new(:nameserver => [ns.name.to_s])

        print ns.name.to_s.ljust(30)

        soa = ns_resolver.getresource(domain, Resolv::DNS::Resource::IN::SOA)
        if soa
          puts "OK (#{soa.serial})"
          serials << soa.serial
        else
          puts "No SOA record found"
        end
        $stdout.flush
      end

      if serials.uniq.size == 1
        puts "\e[32mAll nameservers have the same serial\e[0m"
      elsif serials.empty?
        puts "No nameservers found for #{domain}"
      else
        puts "\e[31mNot all nameservers have the same records\e[0m"
      end
    end
    
  end
end
