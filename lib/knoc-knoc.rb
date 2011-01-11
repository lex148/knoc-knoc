require 'rubygems'
require 'bundler/setup'
require 'net/ping'
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

  def list
    (1..254).map do |n|
      Net::Ping::TCP.new(SUBNET + n.to_s)
    end
  end

end
