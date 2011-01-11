require 'rubygems'
require 'bundler/setup'
#require 'net/ping'
require 'ping'
require 'socket'
require 'macaddr'

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
    @internal_list = []
    list = []
    threads = []
    (1..254).select do |num|
      threads << Thread.new(num) do |n|
        ip = SUBNET + n.to_s
        list.push ip if Ping.pingecho( SUBNET + n.to_s )
      end
    end
    threads.each { |th| th.join }
    @internal_list = list.map{|ip| {:ip => ip, :hostname => get_hostname(ip) }}
  end

  def list
    refresh_list if @internal_list == []
    @internal_list
  end

end
