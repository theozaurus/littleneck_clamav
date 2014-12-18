require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
Bundler::GemHelper.install_tasks

desc 'Run RuboCop'
RuboCop::RakeTask.new(:rubocop)

task default: [:spec, :rubocop]
