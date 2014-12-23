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

    # Returns all the dollar bolsa exchange 'Blue' vs 'Bolsa' info
    #   suitable for user printing analysis
    #
    # @return [String] with all dollar exchange 'Blue' vs 'Bolsa' values
    def get_bolsablue_output
      new.update!(false).bolsablue_output
    end
  end
end
