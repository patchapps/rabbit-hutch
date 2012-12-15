require 'yaml'
    
module RabbitHutch
  class Configurator

    attr_accessor :config

    def initialize options
      
      file = ARGV[0] || (File.dirname(__FILE__) + '/../config.yaml')
      
      puts "Using config from #{file}"
      
      unless File.exists? file
        raise "Configuration file [#{file}] doesn't exist"
      end
      @config = YAML::load(File.open(file))
    end
    
    def application
      @config['application']
    end

    def log_config
      @config['log4r_config']
    end
    
    def consumers
      @config['consumers_config']["consumers"]
    end
        
    def rabbitmq_hosts
      @config['rabbitmq']['hosts']
    end
        
  end
end

