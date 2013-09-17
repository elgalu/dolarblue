require 'configuration'

class Dolarblue
  module InstanceMethods

    # Create a new Dolarblue instance to work later on
    #
    # @param [Config] config the configuration instance
    #
    # @return [Dolarblue] new instance
    def initialize(config = Config.instance)
      fail ArgumentError, "Expected a Dolarblue::Config instance as argument" unless config.is_a?(Config)
      @card_fee = config.card_fee
      @blue = Dolarblue::Exchange.new('Blue', config.blue_screen_name, config.blue_regexp, config.buy_sell_blue_factor)
      @official = Dolarblue::Exchange.new('Official', config.official_screen_name, config.official_regexp, config.buy_sell_official_factor)
      self
    end

    # Returns current object state, whether valid or not
    #
    # @return [true, false] boolean state
    def valid?
      @blue.valid? && @official.valid?
    end

    # Connect to the source and retrieve dollar exchange values
    #
    # @return [self]
    def update!
      print "Obtaining latest AR$ vs US$ exchange values..."
      @blue.update!
      @official.update!
      print "Done.\n\n"
      self
    end

    # Returns the gap between the real (blue) dollar value versus the official
    #
    # @return [Float] percentile value between 0..1
    def gap_official
      fail "Need blue and official values to be setup before calculating the gap" unless @blue.sell_value && @blue.sell_value > 0 && @official.sell_value && @official.sell_value > 0
      (@blue.sell_value / @official.sell_value - 1)
    end

    # Returns the gap percentile between the real (blue) dollar value versus the official
    #
    # @return [Float] percentile value between 0..100
    def gap_official_percent
      (gap_official * 100).round(0)
    end

    def card_fee_sell_value
      (@official.sell_value * @card_fee).round(2)
    end

    # Returns the gap between the real (blue) dollar value versus the dollar "tarjeta" vale
    #
    # @return [Float] percentile value between 0..1
    def gap_card
      fail "Need blue and official values to be setup before calculating the gap" unless @blue.sell_value && @blue.sell_value > 0 && @official.sell_value && @official.sell_value > 0
      (@blue.sell_value / card_fee_sell_value - 1)
    end

    # Returns the gap percentile between the real (blue) dollar value versus the official
    #
    # @return [Float] percentile value between 0..100
    def gap_card_percent
      (gap_card * 100).round(0)
    end

    # Return a string suitable for user output about dollar "tarjeta" values
    #
    # @return [String] output exchange values 1 line string
    def card_output_values
      %Q{- Dolar "Tarjeta":  n/a / #{'%.2f' % card_fee_sell_value}  (Updated #{@official.updated_ago})}
    end

    # Output string to be used by the binary `dolarblue`
    #
    # @return [String] the output with dollar exchange information
    def output
      <<-OUTPUT
#{@official.output_values}
#{card_output_values}
#{@blue.output_values}
- Gap "tarjeta"..: #{gap_card_percent}%
- Gap (official).: #{gap_official_percent}%

Information sources:
#{@official.output_link}
#{@blue.output_link}
      OUTPUT
    end

  end
end
