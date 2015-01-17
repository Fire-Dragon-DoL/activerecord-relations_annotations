# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/relations_annotations/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-relations_annotations"
  spec.version       = ActiveRecord::RelationsAnnotations::VERSION
  spec.authors       = ["Fire-Dragon-DoL"]
  spec.email         = ["francesco.belladonna@gmail.com"]
  spec.summary       = %q{Annotate ActiveRecord relations objects with custom data}
  spec.description   = %q{Annotate ActiveRecord relations objects with custom data, allowing polymorphism on methods for group of records fetched through the same query}
  spec.homepage      = "https://github.com/Fire-Dragon-DoL/activerecord-relations_annotations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"

  spec.add_dependency "activesupport", "~> 4.0"
  spec.add_dependency "activerecord", "~> 4.0"
end
