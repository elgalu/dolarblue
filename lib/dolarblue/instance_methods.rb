class Dolarblue
  module InstanceMethods

    def initialize(config = Configuration.instance)
      fail ArgumentError, "Expected a Dolarblue::Configuration instance as argument" unless config.is_a?(Configuration)
      @blue = Dolarblue::Exchange.new(
        name: 'Blue',
        screen_name: config.blue_screen_name,
        regexp: config.blue_regexp,
        buy_sale_factor: config.buy_sale_factor)
      @official = Dolarblue::Exchange.new(
        name: 'Official',
        screen_name: config.official_screen_name,
        regexp: config.official_regexp,
        buy_sale_factor: config.buy_sale_factor)
    end

    def valid?
      @blue.valid? && @official.valid?
    end

    def update!
      print "Obtaining latest AR$ vs US$ exchange values..."
      @blue.update!
      @official.update!
      print "Done.\n\n"
    end

    def gap
      fail "Need blue and official values to be setup before calculating the gap" unless @blue.sale_value && @blue.sale_value > 0 && @official.sale_value && @official.sale_value > 0
      (@blue.sale_value / @official.sale_value - 1)
    end

    def gap_percent
      (gap * 100).round(0)
    end

    # Output with real values
    #
    # @return [String] the output with dollar exchange information
    def output
      <<-OUTPUT
#{@official.output_values}
#{@blue.output_values}
- Gap.....: #{gap_percent}%

Information sources:
#{@official.output_link}
#{@blue.output_link}
      OUTPUT
    end

  end
end
