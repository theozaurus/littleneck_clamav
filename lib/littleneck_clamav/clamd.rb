require_relative "clam"

class LittleneckClamAV

  class Clamd < Clam

    def command
      "clamdscan"
    end

    def scan(path)
      check_scan! path
      opts = { :swallow_stderr => true, :expected_outcodes => [0, 1] }
      params = "--no-summary -<#{path}"
      output = Cocaine::CommandLine.new( command, params, opts ).run
      parse_result path, output, $?.exitstatus
    end

  end

end
