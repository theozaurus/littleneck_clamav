class LittleneckClamAV
  class Result
    def initialize(opts)
      @path        = opts[:path]
      @clean       = opts[:clean]
      @description = opts[:description]
    end

    attr_reader :path

    def clean?
      @clean
    end

    def infected?
      !clean?
    end

    attr_reader :description
  end
end
