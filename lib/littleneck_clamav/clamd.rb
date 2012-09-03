require_relative "clam"

class LittleneckClamAV

  class Clamd < Clam

    def command
      "clamdscan"
    end

  end

end
