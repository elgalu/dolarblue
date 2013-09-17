lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dolarblue/version'
require 'os'

Gem::Specification.new do |spec|

  spec.platform      = Gem::Platform::RUBY
  spec.name          = "dolarblue"
  spec.version       = Dolarblue::VERSION
  spec.summary       = %q{Query Argentine Peso vs US$ exchange values with particular interest in official vs. street (blue) reference prices.}
  spec.description   = spec.summary

  spec.required_ruby_version     = '>= 1.9.3'
  spec.required_rubygems_version = '>= 2'

  spec.license       = 'MIT'

  spec.authors       = ["Leo Gallucci"]
  spec.email         = ["elgalu3@gmail.com"]
  spec.homepage      = "https://github.com/elgalu/dolarblue"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_runtime_dependency "nokogiri", ">= 1.6.0"
  spec.add_runtime_dependency "time_ago_in_words", ">= 0.1.0"

  # Platform specifics:
  if OS.windows?
    spec.post_install_message  = "Remember to install Grow for Windows from http://www.growlforwindows.com/gfw/"
    spec.add_runtime_dependency "ruby_gntp", ">= 0.3.4"
    ENV['NOTIFY'] = 'ruby_gntp'
  elsif OS.osx?
    spec.post_install_message  = "Currently supported Max OSX >= 10.8 so if you are in an older one please open an issue on github and i will provide you with support."
    spec.add_runtime_dependency  "terminal-notifier", ">= 1.4.2"
    ENV['NOTIFY'] = 'terminal-notifier'
  elsif OS.linux?
    # DO NOTHING, WORKS WELL BY DEFAULT
    #spec.add_runtime_dependency "libnotify", ">= 0.8.1"
    #ENV['NOTIFY'] = 'libnotify'
  end

  # All platforms:
  spec.add_runtime_dependency "notify", ">= 0.5.2"

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rake", ">= 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "redcarpet", ">= 3"
  spec.add_development_dependency "yard", ">= 0.8.7"
  spec.add_development_dependency "simplecov", ">= 0.7.1"
  spec.add_development_dependency "coveralls", ">= 0.6.7"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
end
