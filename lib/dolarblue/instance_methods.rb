require 'dolarblue/configuration'
require 'dolarblue/blue'
require 'dolarblue/official'
require 'dolarblue/bolsa'

require 'nokogiri' # gem 'nokogiri'
require 'open-uri' # stdlib

class Dolarblue

  # Create a new Dolarblue instance to work later on
  #
  # @param config [Configuration] the configuration instance
  #
  # @return [Dolarblue] new instance
  def initialize(config = Configuration.instance)
    @config   = config.defaults
    @blue     = Blue.new
    @official = Official.new
    @bolsa    = Bolsa.new
    self
  end

  # Connect to the source and retrieve dollar exchange values
  #
  # @param log [Boolean] weather to show log standard outputs or not
  #
  # @return (see #initialize)
  def update!(log=true)
    base_url = @config.base_url
    fail ArgumentError, "Need base_url configuration to know where to web-scrape from. Current value: #{base_url}" if base_url.empty?

    log "Obtaining latest AR$ vs US$ exchange values..." if log
    html_file = open(base_url)

    log "Parsing values..." if log
    parse_values Nokogiri::HTML(html_file)

    log "\nDone: #{Time.now.localtime}\n" if log
    self
  end

  # Returns the gap percentile (e.g. 60) between the real (blue) dollar value versus the official
  #
  # @return [Float] percentile value between 0..100
  def gap_official_percent
    gap_official = @blue.sell / @official.sell - 1
    (gap_official * 100).round(0)
  end

  # Returns the gap percentile between the real (blue) dollar value versus the official
  #
  # @return (see #gap_official_percent)
  def gap_bolsa_percent
    gap_bolsa = @blue.sell / @bolsa.sell - 1
    (gap_bolsa * 100).round(0)
  end

  # Output string to be used by the binary `dolarblue`
  #
  # @return [String] the output with dollar exchange information
  def output
    <<-OUTPUT
#{@official.output}
#{@bolsa.output}
#{@blue.output}

- Gap bolsa......blue: #{gap_bolsa_percent}%
- Gap official...blue: #{gap_official_percent}%

Information source:
#{@config.base_url}
    OUTPUT
  end

  # Output string to be used by the binary `bolsablue`
  #
  # @return [String] the output with bolsa/dollar exchange info
  def bolsablue_output
    n = 27
    bol_discount = 0.97
    bolsa_delay_add = 1.01
    payo_discount = 0.967
    net_ticket = 375
    sell_ticket = 396.2

    real = (@blue.sell * bol_discount).round(2)
    profit = n * (real * net_ticket * payo_discount - @bolsa.sell * bolsa_delay_add * sell_ticket)
    now = Time.now.localtime.strftime("%H:%M:%S")

    <<-OUTPUT
Bolsa[#{@bolsa.sell_output}] Blue[#{@blue.sell_output}] Gap[#{gap_bolsa_percent}%] #{now}
#{profit.round(0)}=#{n}*(#{real}*#{net_ticket}*#{payo_discount}-#{@bolsa.sell}*#{bolsa_delay_add}*#{sell_ticket})
    OUTPUT
  end

  private

  # Parse dollar related values using the XPath configured
  #
  # @param doc [Nokogiri::HTML] the html document to extract values from
  #
  # @return [true, false] boolean If parsed successfully or not
  def parse_values(doc)
    [@blue, @official, @bolsa].each do |type|
      type.extract_values(doc)
    end
  end

  # Poor man's logger to keep user updated with http get activity
  #
  # @param msg [String] the message to print or buffer
  def log(msg)
    $stdout.print msg
  end

end
