module KnocKnoc

  class Host

    #@ip, @hostname, @mac = nil, nil, nil
    attr_reader :ip, :hostname, :mac

    def initialize(address)
      @ip = address
      @hostname = get_hostname(address)
      @mac = get_mac(address)
    end


    private 


    def get_mac ip
      mac = /([a-zA-Z0-9]+:)+([a-zA-Z0-9]+)/.match(`arp #{ip}`).to_s
      mac = mac.split /:/
      mac = mac.map{ |p| '%02s' % p }
      mac = mac.map{ |p| p.gsub(' ', '0' ) }
      mac = mac.join(':')
      mac = mac.upcase
      mac = nil if mac == ''
    end

    def get_hostname ip
      r = /pointer.+$/.match(`host #{ip}`)
      if r
        r.to_s.gsub("pointer ", "").gsub(/\.$/,"")
      end
    end

  end

end
