require 'rubygems'
require 'bundler/setup'
#require 'net/ping'
require 'ping'
require 'socket'
#require 'macaddr'

module KnocKnoc
  module_function


  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
    UDPSocket.open do |s|
      s.connect '172.0.0.1', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  def get_hostname ip
    Socket::getaddrinfo(ip,nil)[0][2]
  end

  SUBNET = /([0-9]+\.){3}/.match(local_ip).to_s

  @internal_list = []

  def refresh_list
    @internal_list = full_list 
  end

  def ping_all
    threads, list = [], []
    (1..254).select do |num|
      threads << Thread.new(num) do |n|
        ip = SUBNET + n.to_s
        if Ping.pingecho( SUBNET + n.to_s, 2 )
          list.push( ip )
        end
      end
    end
    threads.each { |th| th.join }
    list
  end

  def full_list
    addresses, threads, list = ping_all, [], []
    addresses.each do |address|
      threads << Thread.new(address) do |a|
          list.push( { :ip => a, :mac => get_mac(a) } )
      end
    end
    threads.each { |th| th.join }
    list
  end

  def list
    refresh_list if @internal_list == []
    @internal_list
  end

  def get_mac ip
    mac = /([a-zA-Z0-9]+:)+([a-zA-Z0-9]+)/.match(`arp #{ip}`).to_s
    mac = mac.split /:/
    mac = mac.map{ |p| '%02s' % p }
    mac = mac.map{ |p| p.gsub(' ', '0' ) }
    mac = mac.join(':')
    mac.upcase
  end

end
