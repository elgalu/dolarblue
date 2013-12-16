require 'configatron/core' # gem 'configatron'
require 'singleton'        # stdlib
require 'yaml'             # stdlib

class Dolarblue

  # Singleton configuration class
  class Configuration
    include Singleton

    # Give memoized defaults for locked configuration options found in /config/xpaths.yml file
    #
    # @example Usage
    #   conf = Configuration.instance.defaults
    #   conf.base_url       #=> "http://ambito.com/economia/mercados/monedas/dolar/"
    #   conf.blue.buy.xpath #=> "//*[@id=\"contenido\"]/div[1]/div[2]/div/div/div[2]/big"
    #
    # @return [Configatron::Store] the magic configuration instance with hash and dot '.' indifferent access
    def defaults
      return @config if @config

      @config = Configatron::Store.new
      file_path   = File.expand_path('../../../config/xpaths.yml', __FILE__)
      hash_config = YAML::load_file(file_path)

      @config.configure_from_hash(hash_config)
      @config.lock!
      @config
    end
  end

end
