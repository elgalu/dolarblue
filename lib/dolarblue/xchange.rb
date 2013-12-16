require 'dolarblue/configuration'
require 'dolarblue/inflector'

class Dolarblue

  # Base class for Blue, Official and Card used to hold sell/buy values functionality
  #
  # @abstract
  class XChange
    attr_reader :buy, :sell

    # Create a new Blue / Official / Card instance to work later on
    #
    # @param config [Configuration] the configuration instance
    #
    # @return [self] new instance
    def initialize(config = Configuration.instance)
      @config = config.defaults
      self
    end

    # Return the demodulized class name
    #
    # @return [String] demodulized class name string
    def cname
      Inflector.demodulize(self.class.name)
    end

    # Return downcased demodulized class name
    #
    # @return [String] downcased demodulized class name string
    def name
      cname.downcase
    end

    # Performs buy and sell values extraction from a Nokogiri::HTML Document
    #
    # @param [Nokogiri::HTML] doc the html document to extract values from
    def extract_values(doc)
      @buy  = extract_val(doc, 'buy')
      @sell = extract_val(doc, 'sell')
    end

    # Return a formatted string suitable for user output with current buy value
    #
    # @return [String] formatted output buy exchange value
    def buy_output
      '%.2f' % buy
    end

    # Return a formatted string suitable for user output with current sell value
    #
    # @return [String] formatted output sell exchange value
    def sell_output
      '%.2f' % sell
    end

    # Return a formatted string suitable for user output with current buy and sell values
    #
    # @return [String] formatted output with buy and sell exchange values
    def output
      t = cname.ljust(10, '.')
      b = buy_output.rjust(5)
      s = sell_output.rjust(5)
      %Q{- Dollar #{t}..: #{b} / #{s}}
    end

    protected

    # Extract individual buy/sell values from a Nokogiri::HTML Document
    #
    # @param doc [Nokogiri::HTML] the html document to extract values from
    # @param type [String] the dollar type, can be 'blue', 'official', 'card'
    #
    # @raise [RuntimeError] if unable to proper buy/sell value for current dollar type
    #
    # @private
    def extract_val(doc, type)
      xpath = @config[name][type].xpath
      value = doc.xpath(xpath).text.gsub(',', '.')
      fail RuntimeError, "Failed to capture #{name} #{type} value" if value.empty?
      value.to_f.round(2)
    end
  end

end
