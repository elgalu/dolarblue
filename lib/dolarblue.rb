require 'dolarblue/version'
require 'dolarblue/configuration'
require 'dolarblue/instance_methods'

# Main class used as builder and also as Dolarblue namespace
class Dolarblue
  class << self
    # Returns all the dollar exchange 'Blue' vs 'Official' values and percentiles
    #   suitable for user printing
    #
    # @return [String] with all dollar exchange 'Blue' vs 'Official' values
    def get_output
      new.update!.output
    end
  end
end
