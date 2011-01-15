require 'rubygems'
require 'bundler/setup'
require 'net/ping'
require 'socket'

require File.dirname(__FILE__) + '/knoc-knoc/host'
require File.dirname(__FILE__) + '/knoc-knoc/watchman'

module KnocKnoc
  module_function

  @watchman = Watchman.new

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
