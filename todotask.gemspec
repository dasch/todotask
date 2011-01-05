# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'todotask/version'

Gem::Specification.new do |s|
  s.name        = 'todotask'
  s.version     = ToDoTask::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Daniel Schierbeck']
  s.email       = ['daniel.schierbeck@gmail.com']
  s.homepage    = 'http://github.com/dasch/rake-todo'
  s.summary     = %q{A Rake task for generating a to-do list}
  s.description = %q{A simple task that extracts to-do items from your Ruby source}

  s.rubyforge_project = 'todotask'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename f }
  s.require_paths = ['lib']

  s.add_dependency 'rake'
end
