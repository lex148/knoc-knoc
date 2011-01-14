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
    @whos_there
  end

  def whos_new
    new_list = @whos_new
    @whos_new = []
    new_list
  end

  def whos_left
    left_list = @whos_left
    @whos_left = []
    left_list
  end


  def refresh_lists
    current_ips = self.ping_all
    whos_there_ips = @whos_there.map{|h| h.ip }
    new_ips = current_ips - whos_there_ips
    left_ips = whos_there_ips - current_ips
    self.update_new_ips new_ips
    self.update_whos_left left_ips
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



  def update_new_ips new_ips
    new_ips.each do |ip|
      host = Host.new(ip)
      @whos_there.push host
      @whos_new.push host
    end
  end

  def update_whos_left left_ips
    left_ips.each do |ip|
      host = @whos_there.find( x => x.ip == ip)
      @whos_there = @whos_there - [host]
      @whos_left.push host
    end
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

  private



end
