lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dolarblue/version'

Gem::Specification.new do |spec|

  spec.platform      = Gem::Platform::RUBY
  spec.name          = 'dolarblue'
  spec.version       = Dolarblue::VERSION
  spec.summary       = %q{Query Argentine Peso vs US$ exchange values with particular interest in official vs. street (blue) reference prices.}
  spec.description   = 'Desc: ' + spec.summary

  spec.required_ruby_version     = '>= 2'
  spec.required_rubygems_version = '>= 1.8.25'

  spec.license       = 'MIT'

  spec.authors       = ['Leo Gallucci']
  spec.email         = ['elgalu3@gmail.com']
  spec.homepage      = 'https://github.com/elgalu/dolarblue'

  spec.require_paths = ['lib']
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_runtime_dependency 'configatron',   '~> 3.2', '>= 3.2.0'
  spec.add_runtime_dependency 'nokogiri',      '~> 1.6', '>= 1.6.2'

  if RUBY_ENGINE == 'rbx'
    spec.add_runtime_dependency 'rubysl'
    spec.add_runtime_dependency 'racc' # Solves https://github.com/rubinius/rubinius/issues/2632#issuecomment-26954565
  end

  spec.add_development_dependency 'bundler', '~> 1.10', '>= 1.10.4'
  spec.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  spec.add_development_dependency 'vcr', '~> 2.9', '>= 2.9.3'
  spec.add_development_dependency 'webmock', '~> 1.21', '>= 1.21.0'
  spec.add_development_dependency 'rubygems-tasks', '~> 0.2', '>= 0.2.4'

end
