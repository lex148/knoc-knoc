require 'rubygems'
require 'bundler/setup'
require 'net/ping'

module KnocKnoc
  module_function

  SUBNET = '10.10.10.'

  def list
    (1..254).map do |n|
      Net::Ping::TCP.new(SUBNET + n.to_s)
    end
  end

end
