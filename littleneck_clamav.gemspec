Gem::Specification.new do |s|
  s.name     = "littleneck_clamav"
  s.version  = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.license  = 'MIT'
  s.author   = "Theo Cushion"
  s.email    = "theo.c@zepler.net"
  s.homepage = "http://github.com/theozaurus/littleneck_clamav"
  s.summary  = "A thin wrapper to make it fast and easy to use ClamAV (daemonised or not) within Ruby"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency 'cocaine'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.11'

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.mdown)
  s.test_files   = Dir.glob("spec/**/*") + %w(.rspec)
  s.require_path = 'lib'
end
