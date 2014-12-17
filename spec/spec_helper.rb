$:.unshift File.join(File.dirname(File.dirname(__FILE__)),'lib')

require "littleneck_clamav"

Dir[File.join(File.dirname(__FILE__),'support','*.rb')].each{|f| require f }

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with   :rspec

  config.disable_monkey_patching!
end
