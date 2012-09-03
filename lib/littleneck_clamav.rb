require_relative "littleneck_clamav/clam"
require_relative "littleneck_clamav/clamd"
require_relative "littleneck_clamav/error"

class LittleneckClamAV

  def engine
    scanner.engine
  end

  def database_version
    scanner.database_version
  end

  def database_date
    scanner.database_date
  end

  def available?
    !!scanner
  end

  def scan(*args)
    scanner.scan(*args)
  end

  def scanner
    @scanner ||= begin
      scanner = scanners.find{|s| s.available? }
      raise Error, "no scanner available, is ClamAV installed?" unless scanner
      scanner
    end
  end

private

  def preference
    [Clamd, Clam]
  end

  def scanners
    @scanners ||= preference.map(&:new)
  end

end
