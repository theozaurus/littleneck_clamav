def result_factory(override = {})
  options = {
    :success     => true,
    :path        => "foo.txt",
    :description => "OK"
  }.merge( override )

  LittleneckClamAV::Result.new options
end
