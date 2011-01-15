require 'rubygems'
require 'bundler/setup'
require 'net/ping'
require 'socket'

require File.dirname(__FILE__) + '/knoc-knoc/host'
require File.dirname(__FILE__) + '/knoc-knoc/watchman'
require File.dirname(__FILE__) + '/knoc-knoc/watchman_live'
require File.dirname(__FILE__) + '/knoc-knoc/watchman_monitor'

module KnocKnoc
  module_function

  def mode
    @watchman.class
  end

  def mode= value
    if value.class == Class
      @watchman.cleanup
      @watchman = value.new
    end
  end

  #set the default mode
  @watchman = WatchmanMonitor.new
  #@watchman = WatchmanLive.new

  def whos_there
    @watchman.whos_there
  end

  def whos_new
    @watchman.whos_new
  end

  def whos_left
    @watchman.whos_left
  end


end
