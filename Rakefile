require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run RSpec examples'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color']
  # TODO: Change '-d' to '--debug' when that `rspec` bug is fixed
  t.rspec_opts << '-d'

  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run RSpec examples'
task '' => :spec
task :default => :spec
