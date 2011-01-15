module KnocKnoc

  class WatchmanLive < Watchman 

    def initialize
      super
      Thread.new() do
        refresh_lists
      end
    end

    def whos_new
      refresh_lists
      super
    end

    def whos_left
      refresh_lists
      super
    end
    
    def whos_there
      refresh_lists
      super
    end

    def cleanup
    end

  end
end
