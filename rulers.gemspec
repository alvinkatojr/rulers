# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rulers/version'

Gem::Specification.new do |spec|
  spec.name          = "rulers"
  spec.version       = Rulers::VERSION
  spec.authors       = ["Alvin Kato J.R."]
  spec.email         = ["alvinkatojr@gmail.com"]

  spec.summary       = %q{A rack based mini web framework }
  spec.description   = %q{Learn web framework development by building a mini version of rails}
  spec.homepage      = "https://github.com/alvinkatojr"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11", ">= 1.11"
  spec.add_development_dependency "rake", "~> 10.4.2", ">=10.4.2"
  spec.add_development_dependency "rest-client", '~> 1.8.0', ">= 1.8.0"
  spec.add_development_dependency "rspec", '~> 3.4.0', ">= 3.4.0"
  spec.add_development_dependency "rack-test", '~> 0.6.3', ">= 0.6.3"
  spec.add_development_dependency "test-unit", '~> 3.1.7', ">= 3.1.7"
  spec.add_runtime_dependency "rack", '~> 1.6','>= 1.6.4'
  spec.add_runtime_dependency "erubis"
end
