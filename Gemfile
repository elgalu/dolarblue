source 'https://rubygems.org'

# Specify your gem's dependencies in dolarblue.gemspec
gemspec

# installing pry doesn't work anymore (ruby 2.2.2)
# group :development do
#   gem 'pry'     # core replacement for irb
#   gem 'pry-doc' # gives MRI core documentation and source code
# end

unless %w(jruby rbx).include? RUBY_ENGINE
  group :test do
    # Coverage reports only for MRI
    # https://github.com/colszowka/simplecov/releases
    gem 'simplecov', '>= 0.10.0'
    # https://github.com/lemurheavy/coveralls-ruby/releases
    gem 'coveralls', '>= 0.7.12'
  end

  group :development do
    gem 'redcarpet', '>= 3.1.1'  # redcarpet doesn't currently works with jruby nor rbx. kramdown is a possible alternative
    gem 'yard', '>= 0.8.7.4' # no need to generate yard docs from jruby nor rbx
    # gem 'pry-stack_explorer' # adds command `show-stack`
    # gem 'pry-debugger'       # adds commands `continue, step, next, finish`
  end
end
