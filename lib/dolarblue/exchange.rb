require 'twitter_anonymous_client'
require 'time_ago_in_words'

class Dolarblue

  # Used to build dollar exchange value object
  class Exchange
    attr_reader :name, :source_url, :updated_at

    # Create a new dollar exchange value instance
    #
    # @param [String] name the name of the object
    #   actual values are 'Blue' and 'Official'
    # @param [String] screen_name the twitter screen_name from which to retrieve the values
    # @param [Regexp] regexp the regular expressions to be used to parse the dollar values from the tweet text
    # @param [Float] buy_sell_factor the factor to multiply sale value in order to get buy value
    #   difference is usually 1% so a factor of 0.99 would apply to get that
    #
    # @return [self]
    #
    # @note Using ruby 2 feature: Keyworded Arguments
    def initialize(name: nil, screen_name: nil, regexp: nil, buy_sell_factor: nil)
      fail ArgumentError, "name, screen_name, regexp and buy_sell_factor are all required" unless name && screen_name && regexp && buy_sell_factor
      @name = name
      @screen_name = screen_name
      @regexp = regexp
      @buy_sell_factor = buy_sell_factor
      @sell_value = nil
      @source_url = nil
      @updated_at = nil
      self
    end

    # Buy (lowest) dollar exchange value
    #   usually obtained from sell value multiplied by sell factor
    #
    # @return [Float] lowest dollar exchange value
    def buy_value
      ensure_valid
      (@sell_value * @buy_sell_factor).round(2)
    end

    # Sell (highest) dollar exchange value
    #   usually obtained directly from the source
    #
    # @return [Float] highest dollar exchange value
    def sell_value
      ensure_valid
      @sell_value.round(2)
    end

    # Returns valid state
    #
    # @return [true, false] valid boolean state
    def valid?
      @sell_value && @sell_value.kind_of?(Numeric) && @sell_value > 0
    end

    # Connect to the source and retrieve dollar exchange value
    #
    # @return [self]
    def update!
      tweet = Twitter::Client.new.last_tweet(@screen_name)
      fail "Couldn't obtain value out of #{tweet.text}" unless tweet.text =~ @regexp
      @sell_value = Float("#{$1}.#{$2}")
      @updated_at = tweet.created_at
      @source_url = tweet.status_url
      self
    end

    # Return the last updated time from now humanized in English words
    #
    # @return [String] humanized ago date in English
    def updated_ago
      ensure_valid
      @updated_at.to_time.ago_in_words
    end

    # Return a string suitable for user output about exchange values
    #
    # @return [String] output exchange values 1 line string
    def output_values
      ensure_valid
      dots = '.' * (8 - name.size).abs
      "- #{name}#{dots}: #{buy_value} / #{sell_value}  (Updated #{updated_ago})"
    end

    # Return a string suitable for user output with the link to the sources
    #
    # @return [String] output links with sources from which the values where obtained
    def output_link
      ensure_valid
      dots = '.' * (8 - name.size).abs
      "#{name}#{dots}: #{source_url}"
    end

    private

    # Ensure object is valid before continuing with certain operations
    #   like getting output strings or last updated date
    #
    # @private
    def ensure_valid
      fail "Call update! first" unless valid?
    end
  end

end
