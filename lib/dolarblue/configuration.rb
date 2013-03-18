require 'singleton'

class Dolarblue

  # Singleton configuration class
  class Configuration
    include Singleton

    # Default gap factor between the sale value vs. the buy value
    # Usually 1%
    #
    # @return [Float] the percentile between 0..1
    def buy_sell_factor
      Float(0.99)
    end

    # Twitter screen name for the `blue` dollar value
    #
    # @return [String] the twitter screen name for the `blue` dollar value
    def blue_screen_name
      'DolarBlue'
    end

    # Regular expression to be used to match the Tweet text for `blue` value
    # In order to extract the integer value from $1 and the decimal value from $2
    #
    # @return [Regexp] the regular expression to be used to match the Tweet text for `blue` value
    def blue_regexp
      /\$(\d+)[\.,](\d+)/
    end

    # Twitter screen name for the official (legal) dollar value
    #
    # @return [String] the twitter screen name for the official (legal) dollar value
    def official_screen_name
      'cotizacionhoyar'
    end

    # Regular expression to be used to match the Tweet text for official value
    # In order to extract the integer value from $1 and the decimal value from $2
    #
    # @return [Regexp] the regular expression to be used to match the Tweet text for official value
    def official_regexp
      /[Dd]olar: (\d+)[\.,](\d+)/
    end

    # Dollar "tarjeta" AR fee on top of official value
    #
    # @return [Float] the dollar "tarjeta" AR fee to be applied, e.g. 1.2 for an extra 20% charge
    def card_fee
      1.2
    end
  end

end
