module KnocKnoc

  class WatchmanMonitor < Watchman

    def initialize
      super
      @running = true
      #run the refresh_lists once before 
      #starting the set interval
      Thread.new() do 
        self.refresh_lists
        self.repeat_every(30) do 
          self.refresh_lists
        end
      end
    end

    def repeat_every(interval, &block)
      while @running 
        start_time = Time.now
        Thread.new(&block).join
        elapsed = Time.now - start_time
        sleep([interval - elapsed, 0].max)
      end
    end

    def cleanup
      @running = false
    end

  end
end
