module KnocKnoc

  class Watchman

    attr_reader :whos_there, :whos_left, :whos_new

    def self.local_ip
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
      UDPSocket.open do |s|
        s.connect '172.0.0.1', 1
        s.addr.last
      end
    ensure
      Socket.do_not_reverse_lookup = orig
    end

    SUBNET = /([0-9]+\.){3}/.match(self.local_ip).to_s

    def initialize
      @whos_there, @whos_new, @whos_left = [], [], []
      #run the refresh_lists once before 
      #starting the set interval
      Thread.new() do |a|
        self.refresh_lists
        self.repeat_every(30) do 
          self.refresh_lists
        end
      end
    end

    def whos_new
      list = @whos_new
      @whos_new = []
      list
    end

    def whos_left
      list = @whos_left
      @whos_left = []
      list
    end

    def refresh_lists
      current_ips = self.ping_all
      whos_there_ips = @whos_there.map{|h| h.ip }
      new_ips = current_ips - whos_there_ips
      left_ips = whos_there_ips - current_ips
      self.update_new_ips new_ips
      self.update_whos_left left_ips
    end





    def update_new_ips new_ips
      new_ips.each do |ip|
        host = Host.new(ip)
        @whos_there.push host
        @whos_new.push host
      end
    end
   
    def update_whos_left left_ips
      left_ips.each do |ip|
        host = @whos_there.find{ |x| x.ip == ip }
        @whos_there = @whos_there - [host]
        @whos_left.push host
      end
    end

    def ping_all
      threads, list = [], []
      (1..254).select do |num|
        threads << Thread.new(num) do |n|
          ip = SUBNET + n.to_s
          if Net::Ping::External.new(ip, 1).ping?
            list.push( ip )
          end
        end
      end
      threads.each { |th| th.join }
      list
    end


    def repeat_every(interval, &block)
      loop do
        start_time = Time.now
        Thread.new(&block).join
        elapsed = Time.now - start_time
        sleep([interval - elapsed, 0].max)
      end
    end


  end
end
