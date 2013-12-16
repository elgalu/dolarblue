class Dolarblue
  module Inflector
    extend self

    # Removes the module part from the expression in the string.
    #
    # @param path [String] the module expression stringified
    #
    # @example
    #   demodulize('ActiveRecord::CoreExtensions::String::Inflections') # => "Inflections"
    #   demodulize('Inflections')                                       # => "Inflections"
    #
    # @return [String] with the module part removed and the stringified class name only
    def demodulize(path)
      path = path.to_s
      if i = path.rindex('::')
        path[(i+2)..-1]
      else
        path
      end
    end
  end
end
