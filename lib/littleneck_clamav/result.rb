class LittleneckClamAV

  class Result

    def initialize(opts)
      @path        = opts[:path]
      @clean       = opts[:clean]
      @description = opts[:description]
    end

    def path
      @path
    end

    def clean?
      @clean
    end

    def infected?
      !@clean
    end

    def description
      @description
    end

  end

end
