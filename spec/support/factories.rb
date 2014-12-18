def result_factory(override = {})
  options = {
    success: true,
    path: 'foo.txt',
    description: 'OK'
  }.merge(override)

  LittleneckClamAV::Result.new options
end

def mock_cocaine(cocaine_options = {})
  MockCocaine.new(cocaine_options).mock
end

class MockCocaine
  include RSpec::Mocks::ExampleMethods

  def initialize(options)
    @options = defaults.merge(options)
  end

  def mock
    build_mock
    setup_exit_value
  end

  private

  attr_reader :options

  def defaults
    { output: '', exitvalue: 0 }
  end

  def build_mock
    mock = expect(Cocaine::CommandLine).to receive(:new)
    mock.with(
      options[:cmd], options[:opts], options[:params]
    ) if any_argument_options?

    mock.and_return(cocaine_command_double)
    mock.and_raise(options[:raise]) if options.key?(:raise)
  end

  def cocaine_command_double
    double 'cocaine command', run: options[:output]
  end

  def any_argument_options?
    options[:cmd] || options[:opts] || options[:params]
  end

  def setup_exit_value
    options[:exitvalue] == 0 ? `true` : `false`
  end
end
