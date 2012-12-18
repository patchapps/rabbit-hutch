require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/syslogoutputter'

  class Logger
  	@@log = nil
  	def self.init(config)
  		if !@@log.nil? 
  			return @@log
  		end
  
  		configurator = Log4r::YamlConfigurator 
  		configurator.decode_yaml config.log_config
  		@@log = Log4r::Logger['main']
  	end
  end
