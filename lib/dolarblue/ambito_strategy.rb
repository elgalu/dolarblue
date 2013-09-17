require 'nokogiri' #gem install nokogiri
require 'open-uri' #stdlib

module Dolarblue
  class Exchange
    attr_accessor :buy_value, :sell_value, :buy_xpath, :sell_xpath

    # def initialize(xpath)
    #   @source_xpath = xpath
    # end
  end
end

module DollarScraping
  class Entity
    attr_accessor :buy_xpath, :sell_xpath

    def get_buy_value
      #TODO
    end
  end
end

class DollarScrapingService
  # Target url
  attr_reader :base_url
  # Dollar types
  attr_reader :blue, :green, :official, :card

  def initialize(base_url)
    @base_url = base_url
  end
end

class AmbitoStrategy < DollarScrapingService
  def initialize(base_url)
    super
    @blue = Exchange.new do
      buy_xpath  = '//*[@id="contenido"]/div[1]/div[2]/div/div/div[2]/big'
      sell_xpath = '//*[@id="contenido"]/div[1]/div[2]/div/div/div[3]/big'
    end
  end
end

# Usage:
strategy = AmbitoStrategy.new(Config.instance.base_url)
