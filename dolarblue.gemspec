lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dolarblue/version'

Gem::Specification.new do |spec|

  spec.platform      = Gem::Platform::RUBY
  spec.name          = "dolarblue"
  spec.version       = Dolarblue::VERSION
  spec.summary       = %q{Query Argentine Peso vs US$ exchange values with particular interest in official vs. ilegal (blue) reference prices.}
  spec.description   = spec.summary

  spec.required_ruby_version     = '>= 1.9.2'
  spec.required_rubygems_version = '>= 1.3.6'

  spec.license       = 'MIT'

  spec.authors       = ["Leo Gallucci"]
  spec.email         = ["elgalu3@gmail.com"]
  spec.homepage      = "https://github.com/elgalu/dolarblue"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_runtime_dependency "twitter_anonymous_client", ">= 1.0.2.0"
  spec.add_runtime_dependency "time_ago_in_words", ">= 0.1.0"

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency "redcarpet", ">= 2.2.2"
  spec.add_development_dependency "yard", ">= 0.8.5.2"
  spec.add_development_dependency "simplecov", ">= 0.7.1"
  spec.add_development_dependency 'coveralls', '>= 0.6.2'

end
