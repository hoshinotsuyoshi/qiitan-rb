# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/discovery_etcd_io/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-discovery_etcd_io"
  spec.version       = Ruboty::DiscoveryEtcdIo::VERSION
  spec.authors       = ["hoshinotsuyoshi"]
  spec.email         = ["guitarpopnot330@gmail.com"]
  spec.summary       = %q{pstore as Ruboty::Brains}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/hoshinotsuyoshi/ruboty-discovery_etcd_io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"
  spec.add_runtime_dependency "discovery_etcd_io_client"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
