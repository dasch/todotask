
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rtagstask'

require 'lib/todotask/version'

SVN_URL = 'svn+ssh://dasch@rubyforge.org/var/svn/todotask'

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

namespace :svn do
  desc 'Tag this release'
  task :tag do
    sh "svn copy #{SVN_URL}/trunk " +
       "#{SVN_URL}/tags/release-#{ToDoTask::VERSION} " +
       '-m "tagging release ' + ToDoTask::VERSION + '"'
  end
end

task :release => [:'svn:tag', :package]

desc 'Install gem'
task :install => :package do
  sh 'sudo gem install pkg/todotask'
end

desc 'Uninstall gem'
task :uninstall do
  sh 'sudo gem uninstall todotask'
end
