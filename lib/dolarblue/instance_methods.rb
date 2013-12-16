require 'dolarblue/configuration'
require 'dolarblue/blue'
require 'dolarblue/official'
require 'dolarblue/card'

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
    @card     = Card.new
    self
  end

  # Connect to the source and retrieve dollar exchange values
  #
  # @return (see #initialize)
  def update!
    base_url = @config.base_url
    fail ArgumentError, "Need base_url configuration to know where to web-scrape from. Current value: #{base_url}" if base_url.empty?

    log "Obtaining latest AR$ vs US$ exchange values..."
    html_file = open(base_url)

    log "Parsing values..."
    parse_values Nokogiri::HTML(html_file)

    log "\nDone: #{Time.now.localtime}\n"
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
  def gap_card_percent
    gap_card = @blue.sell / @card.sell - 1
    (gap_card * 100).round(0)
  end

  # Output string to be used by the binary `dolarblue`
  #
  # @return [String] the output with dollar exchange information
  def output
    <<-OUTPUT
#{@official.output}
#{@card.output}
#{@blue.output}

- Gap card.......blue: #{gap_card_percent}%
- Gap official...blue: #{gap_official_percent}%

Information source:
#{@config.base_url}
    OUTPUT
  end

  private

  # Parse dollar related values using the XPath configured
  #
  # @param doc [Nokogiri::HTML] the html document to extract values from
  #
  # @return [true, false] boolean If parsed successfully or not
  def parse_values(doc)
    [@blue, @official, @card].each do |type|
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
