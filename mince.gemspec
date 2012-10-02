# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'mingo/version'

Gem::Specification.new do |s|
  s.name        = "mingo"
  s.version     = Mince::Mingo.version
  s.authors     = ["Matt Simpson", "Jason Mayer", "Asynchrony"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/asynchrony/#{s.name}"
  s.summary     = %q{Lightweight MongoDB ORM for Ruby.}
  s.description = %q{Mince interface library to provide a lightweight MongoDB ORM for Ruby.}

  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('mongo', '~> 1.5.2')
  s.add_dependency('bson_ext', '~> 1.5.2')
  s.add_dependency('activesupport', '~> 3.0')

  s.add_development_dependency('rake', '~> 0.9')
  s.add_development_dependency('rspec', '~> 2.0')
  s.add_development_dependency('guard-rspec', '~> 0.6')
  s.add_development_dependency "yard", "~> 0.7"
  s.add_development_dependency "redcarpet", "~> 2.1"
  s.add_development_dependency "debugger", "~> 1.2"
  s.add_development_dependency "mince", "2.0.0.pre"
end
