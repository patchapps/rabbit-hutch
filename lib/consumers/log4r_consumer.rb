# encoding: utf-8
require 'rubygems'
require 'log4r'
#require 'log4r/outputter/syslogoutputter'

module RabbitHutch
  class Log4rConsumer
      
    def initialize(rabbitmq_host, config)
      puts "\tInitializing Log4r Consumer"
      @rabbitmq_host = rabbitmq_host
      @config = config
      @log_name = rabbitmq_host["displayname"]
      @config.consumers.each do |consumer|
        if consumer["name"] == 'log4r_consumer'
          @log_prefix = consumer['log_prefix']
          @log_location = consumer['log_location']
        end
      end
      
      
      @logger = Log4r::Logger.new("#{@log_name}#_log")
      @logger.outputters << Log4r::FileOutputter.new("#{@log_name}_filelog", :filename =>  "#{@log_location}/#{@log_prefix}#{@log_name}.log")
    end
        
    def log_event(item)
      begin  
        @logger.info(item)    
      rescue Exception => e
        puts "Error occurred Message Handler trying to write messages to Log #{e.inspect}" 
        #@log.error("Error occurred Message Handler trying to write messages to MONGODB #{e.inspect}") 
      end
    end 
  end
end
