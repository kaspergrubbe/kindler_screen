# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kindler/version'

Gem::Specification.new do |spec|
  spec.name          = "kindler"
  spec.version       = Kindler::VERSION
  spec.authors       = ["Kasper Grubbe"]
  spec.email         = ["kawsper@gmail.com"]

  spec.summary       = %q{Project to generate Kindle images and show them on a Kindle.}
  spec.homepage      = "https://github.com/kaspergrubbe/kindler"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|kindle_scripts)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "poltergeist"
  spec.add_runtime_dependency "haml"
end
