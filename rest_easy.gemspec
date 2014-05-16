# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'base64'
require 'rest_easy/version'

Gem::Specification.new do |spec|
  spec.name          = "rest_easy"
  spec.version       = RestEasy::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["James Crumpton"]
  spec.email         = [Base64.decode64('amFtZXMuY3J1bXB0b25AZ21haWwuY29t')]
  spec.summary       = %q{Rest Easy: DRYs up your CRUD actions and resource finders.}
  spec.description   = %q{DRYs up your CRUD actions and resource finders.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
end
