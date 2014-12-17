def result_factory(override = {})
  options = {
    :success     => true,
    :path        => "foo.txt",
    :description => "OK"
  }.merge( override )

  LittleneckClamAV::Result.new options
end

def mock_cocaine(cocaine_options={})
  options = { :output => "", :exitvalue => 0 }.merge( cocaine_options )
  mock = expect(Cocaine::CommandLine).to receive(:new)
  mock = mock.with(
    options[:cmd], options[:opts], options[:params]
  ) if options[:cmd] || options[:opts] || options[:params]

  if cocaine_options[:raise]
    mock.and_raise cocaine_options[:raise]
  else
    mock.and_return(
      double "cocaine command", :run => options[:output]
    )
  end

  `true`  if options[:exitvalue] == 0
  `false` if options[:exitvalue] == 1
end
