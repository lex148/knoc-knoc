require 'rubygems'
require 'bundler/setup'
#require 'net/ping'
require 'ping'
require 'socket'

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

  SUBNET = /([0-9]+\.){3}/.match(local_ip).to_s

  @internal_list = []

  def refresh_list
    @internal_list = []
    threads = []
    (1..254).select do |num|
      threads << Thread.new(num) do |n|
        ip = SUBNET + n.to_s
        @internal_list.push ip if Ping.pingecho( SUBNET + n.to_s )
      end
    end
    threads.each { |th| th.join }
    @internal_list
  end

  def list
    @internal_list
  end

end
