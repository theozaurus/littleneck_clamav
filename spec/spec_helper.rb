$:.unshift File.join(File.dirname(File.dirname(__FILE__)),'lib')

require "littleneck_clamav"
require "rspec/mocks/any_instance"

Dir[File.join(File.dirname(__FILE__),'support','*.rb')].each{|f| require f }

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with   :rspec
end
