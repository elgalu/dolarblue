require 'singleton' #stdlib
require 'fileutils' #stdlib
require 'yaml' #stdlib

require 'os' #dolarblue
if OS.windows?
	# Open the "Task Scheduler" to check if it is running
	cmd = 'schtasks'
	args = "/create /tn Dolarblue /tr dolarblue /sc minute"
end

class Dolarblue

  class Config
    include Singleton

    attr_accessor :base_url
    attr_accessor :poll_every
    attr_reader :interval

    # Set @poll_every and @interval
    #
    # @param [String] value the humanized string interval
    def poll_every=(value)
    	@poll_every = value
  		#TODO convert to ???? type
  		#@interval = ?
    end

    def default_base_url
    	"http://ambito.com/economia/mercados/monedas/dolar/"
    end

    def default_poll_every
    	"5m"
    end

    def config_file_path
    	File.join(File.expand_path('~'), '.dolarblue_config.yml')
    end

    def latest_file_path
    	File.join(File.expand_path('~'), '.dolarblue_latest.yml')
    end

    class << self
	    def load_config(c = Config.instance)
	    	ensure_config_file
    		yaml = File.read(c.config_file_path)
    		conf = YAML.load(yaml)
    		c.base_url = conf['base_url'] || c.default_base_url
    		c.poll_every = conf['poll_every'] || c.default_poll_every
	    end

	    def load_latest(c = Config.instance)
	    	ensure_latest_file
	    	#TODO
	    end

	    def ensure_config_file(c = Config.instance)
	    	source = ?
	    	FileUtils.cp(source, c.config_file_path) unless File.exists?(c.config_file_path)
	    end

	    def ensure_latest_file(c = Config.instance)
	    	#TODO
	    end
  	end

  end

end
