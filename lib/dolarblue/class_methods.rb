class Dolarblue
  module ClassMethods
    # Returns all the dollar exchange 'Blue' vs 'Official' values and percentiles
    #   suitable for user printing
    #
    # @return [String] with all dollar exchange 'Blue' vs 'Official' values
    def get_output
      new.update!.output
    end
  end
end
