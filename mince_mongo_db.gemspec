# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'mince_mongo_db/version'

Gem::Specification.new do |s|
  s.name        = "mince_mongo_db"
  s.version     = MinceMongoDb.version
  s.authors     = ["Matt Simpson", "Jason Mayer", "Asynchrony"]
  s.email       = ["matt@railsgrammer.com", "jason.mayer@gmail.com"]
  s.homepage    = "https://github.com/coffeencoke/#{s.name}"
  s.summary     = %q{Lightweight MongoDB ORM for Ruby.}
  s.description = %q{Mince interface library to provide a lightweight MongoDB ORM for Ruby.}

  s.rubyforge_project = s.name

  s.files = %w(
    lib/mince_mongo_db.rb
    lib/mince_mongo_db/config.rb
    lib/mince_mongo_db/connection.rb
    lib/mince_mongo_db/data_store.rb
    lib/mince_mongo_db/interface.rb
    lib/mince_mongo_db/version.rb
  )
  s.test_files = %w(
    spec/integration/mince_interface_spec.rb
    spec/units/mince_mongo_db/config_spec.rb
    spec/units/mince_mongo_db/connection_spec.rb
    spec/units/mince_mongo_db/data_store_spec.rb
    spec/units/mince_mongo_db/interface_spec.rb
  )
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
  s.add_development_dependency "mince", "2.0.0.pre.2"
  s.add_development_dependency "rb-fsevent", "~> 0.9.0"
end
