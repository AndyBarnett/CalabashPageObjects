# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CalabashPageObjects/version'

Gem::Specification.new do |spec|
  spec.name          = 'calabash-page-objects'
  spec.version       = CalabashPageObjects::VERSION
  spec.authors       = ['Alan Nichols and Andrew Barnett']
  spec.email         = ['alan.nichols@outlook.com', 'bandy1@live.co.uk']
  spec.summary       = 'Page Object framework for Calabash'
  spec.description   = 'Page Object frameworks for Calabash on iOS and Android'
  spec.homepage      = 'https://github.com/justeat/CalabashPageObjects'
  spec.license       = 'Eclipse Public License v1.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'calabash-android', '>=0.5.14'
  spec.add_development_dependency 'calabash-cucumber'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-expectations'
end
