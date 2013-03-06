require 'twitter_anonymous_client'
require 'time_ago_in_words'

class Dolarblue

  class Exchange
    attr_reader :name, :source_url, :updated_at

    # @note Using ruby 2 feature: Keyworded Arguments
    def initialize(name: nil, screen_name: nil, regexp: nil, buy_sale_factor: nil)
      fail ArgumentError, "name, screen_name, regexp and buy_sale_factor are all required" unless name && screen_name && regexp && buy_sale_factor
      @name = name
      @screen_name = screen_name
      @regexp = regexp
      @buy_sale_factor = buy_sale_factor
      @sale_value = nil
      @source_url = nil
      @updated_at = nil
    end

    def buy_value
      ensure_valid
      (@sale_value * @buy_sale_factor).round(2)
    end

    def sale_value
      ensure_valid
      @sale_value.round(2)
    end

    def valid?
      @sale_value && @sale_value.kind_of?(Numeric) && @sale_value > 0
    end

    def update!
      tweet = Twitter::Client.new.last_tweet(@screen_name)
      fail "Couldn't obtain value out of #{tweet.text}" unless tweet.text =~ @regexp
      @sale_value = Float("#{$1}.#{$2}")
      @updated_at = tweet.created_at
      @source_url = tweet.status_url
    end

    def updated_ago
      ensure_valid
      @updated_at.to_time.ago_in_words
    end

    def output_values
      ensure_valid
      dots = '.' * (8 - name.size).abs
      "- #{name}#{dots}: #{buy_value} / #{sale_value}  (Updated #{updated_ago})"
    end

    def output_link
      ensure_valid
      dots = '.' * (8 - name.size).abs
      "#{name}#{dots}: #{source_url}"
    end

    private

    def ensure_valid
      fail "Call update! first" unless valid?
    end
  end

end
