class Dolarblue
  module ClassMethods
    # Provides a sample output string when no arguments nor params are present
    #
    # @return [String] the multiline sample content
    def sample_output
      <<-HARDCODED
Obtaining latest AR$ vs US$ exchange values...Done.

- Official: 5.01 / 5.06  (Updated 2 hours and 38 minutes ago)
- Blue....: 7.74 / 7.82  (Updated 9 minutes and 56 seconds ago)
- Gap.....: 55%

Information sources:
Official: https://twitter.com/cotizacionhoyar/status/309289043722637312
Blue....: https://twitter.com/DolarBlue/status/309326405148233731
      HARDCODED
    end
  end
end
