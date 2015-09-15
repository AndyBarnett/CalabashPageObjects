# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CalabashPageObjects/version'

Gem::Specification.new do |spec|
  spec.name          = 'CalabashPageObjects'
  spec.version       = CalabashPageObjects::VERSION
  spec.authors       = ["Alan Nichols and Andrew Barnett"]
  spec.email         = ["alan.nichols@just-eat.com"]
  spec.summary       = "Page Object framework for calabash"
  spec.description   = "Page Object frameworks for calabash on iOS and Android"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "calabash-android"
  spec.add_development_dependency "calabash-cucumber"
  spec.add_development_dependency "geminabox"
end