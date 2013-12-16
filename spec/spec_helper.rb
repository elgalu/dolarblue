unless %w(jruby rbx).include? RUBY_ENGINE
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start
end

require 'dolarblue'

# Require this file using `require "spec_helper"` within each of your specs
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random' # Run specs in random order to surface order dependencies.
  config.expect_with :rspec do |c|
    c.syntax = :expect  # disable `should` syntax  http://goo.gl/BGxqP
  end
end

require 'vcr' # gem 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { allow_playback_repeats: true, record: :new_episodes }
  c.configure_rspec_metadata!
end

# VCR + Rspec integration
RSpec.configure do |config|
  config.before(:suite) { VCR.insert_cassette 'Dolarblue' }
  config.after(:suite)  { VCR.eject_cassette }
end
