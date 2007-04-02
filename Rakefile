
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rtagstask'

require 'lib/todotask/version'

Rake::TestTask.new(:test)

Rake::RDocTask.new(:docs) do |t|
  t.rdoc_dir = 'doc'
end

RTagsTask.new

spec = Gem::Specification.new do |s|
  s.name       = 'todotask'
  s.version    = ToDoTask::VERSION
  s.author     = 'Daniel Schierbeck'
  s.summary    = 'A Rake task for generating a ToDo list'
  s.files      = FileList['lib/**/*.rb']
  s.test_files = FileList['test/**/*.rb']
end

Rake::GemPackageTask.new(spec) do |t|
  t.need_tar = true
end

desc 'Install gem'
task :install => :package do
  sh 'sudo gem install pkg/todotask'
end

desc 'Uninstall gem'
task :uninstall do
  sh 'sudo gem uninstall todotask'
end
