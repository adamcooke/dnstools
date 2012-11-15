module DNSTools
  class Commands
    
    desc "nscheck example.com", "Checks the NS records for a domain and ensures they all return the same data"
    def nscheck(domain)
      root_resolver = Resolv::DNS.new(:nameserver => ['8.8.8.8', '141.1.1.1', '8.8.4.4'])

      nameservers = root_resolver.getresources(domain, Resolv::DNS::Resource::IN::NS)
      serials = []

      for ns in nameservers
        ns_resolver = Resolv::DNS.new(:nameserver => [ns.name.to_s])

        print ns.name.to_s.ljust(30)

        soa = ns_resolver.getresource(domain, Resolv::DNS::Resource::IN::SOA)
        if soa
          ip = root_resolver.getresource(ns.name.to_s, Resolv::DNS::Resource::IN::ANY)
          print ip.address.to_s.ljust(25)
          print soa.serial
          serials << soa.serial
        else
          puts "No SOA record found"
        end
        puts
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
