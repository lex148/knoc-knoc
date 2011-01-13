require 'rubygems'
require 'bundler/setup'
#require 'net/ping'
require 'ping'
require 'socket'

require File.dirname(__FILE__) + '/knoc-knoc/host'

module KnocKnoc
  module_function


  @whos_there, @whos_new, @whos_left = [], [], []

  def whos_there
    @internal_list
  end

  def whos_new
  end

  def whos_left
  end


  def refresh_lists
    current_ips = ping_all
    
  end

  
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

  private

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




end
