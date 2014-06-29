# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ba_rewards/version'

Gem::Specification.new do |spec|
  spec.name          = "ba_rewards"
  spec.version       = BARewards::VERSION
  spec.summary       = %Q{A gem for checking availability of British Airways Avios redemptions}
  spec.authors       = ["Tim Rogers"]
  spec.email         = ["me@timrogers.co.uk"]
  spec.summary       = %Q{A gem for checking availability of British Airways Avios redemptions}
  spec.homepage      = "https://github.com/timrogers/ba_rewards"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", '~> 2.14.0'
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "httparty"
end
