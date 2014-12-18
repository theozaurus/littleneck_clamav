require 'cocaine'
require 'english'
require 'time'

require_relative 'result'
require_relative 'error'

class LittleneckClamAV
  class Clam
    def engine
      version[:engine] if available?
    end

    def database_version
      version[:database_version].to_i if available?
    end

    def database_date
      Time.parse(version[:database_date]) if available?
    end

    def available?
      version[:success]
    end

    def scan(path)
      check_scan! path
      opts = { swallow_stderr: true, expected_outcodes: [0, 1] }
      params = ['--no-summary', %("#{path}")].join(' ')
      output = Cocaine::CommandLine.new(command, params, opts).run
      parse_result path, output, $CHILD_STATUS.exitstatus
    end

    def command
      'clamscan'
    end

    private

    def version
      @version ||= begin
        opts = { swallow_stderr: true }
        params = '--version'
        output = Cocaine::CommandLine.new(command, params, opts).run.strip
        parse_output(output)
      rescue Cocaine::ExitStatusError, Cocaine::CommandNotFoundError => e
        { error: e.message, success: false }
      end
    end

    def parse_output(output)
      engine, db_version, db_date = output.sub(/^ClamAV /, '').split('/', 3)
      success = !(db_version && db_date).nil?
      {
        output: output,
        engine: engine,
        database_version: db_version,
        database_date: db_date,
        success: success
      }
    end

    def parse_result(path, output, _code)
      clean = $CHILD_STATUS.exitstatus == 0
      description = output.split(':').last.strip
      description.sub! ' FOUND', ''
      Result.new path: path, clean: clean, description: description
    end

    def check_scan!(path)
      exists = File.exist? path
      if !exists
        fail Error, "the path #{path} does not exist"
      elsif !available?
        message = "#{self.class} is not available"
        message << "because #{version[:message]}" if version[:message]
        fail Error, message
      end
    end
  end
end
