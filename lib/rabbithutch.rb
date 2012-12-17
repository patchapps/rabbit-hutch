require 'rubygems'
require "amqp"
require_relative "configurator"
require_relative "consumers/mongo_consumer"
require_relative "consumers/log4r_consumer"
require_relative "consumers/console_consumer"
require_relative "worker"

  @config = RabbitHutch::Configurator.new({})
  @log = nil #RabbitHutch::MyLogger.init(@config) 
  
  puts "-------------------------"
  puts "Starting RabbitHutch"
  puts "\tEnvironment Settings"
  @config.rabbitmq_hosts.each do |rabbitmq_host|
    puts "\tDisplay Name: #{rabbitmq_host["displayname"]}, host: #{rabbitmq_host["hostname"]}, username: #{rabbitmq_host["username"]}, enabled #{rabbitmq_host["enabled"]}"
  end
  
  # Initialize all enabled consumners
  # NOTE: this method will be replaced with a routine to reflect through all valid consumers and initialze them implicitly   
  def initialize_consumers(rabbitmq_host)
    puts "Initializing Consumers for #{rabbitmq_host["displayname"]}"
    consumers = []
    @config.consumers.each do |consumer|
      if consumer["enabled"] == true
        case consumer["name"]
          when "console_consumer"
            consumers << RabbitHutch::ConsoleConsumer.new()
          when "mongo_consumer"
            consumers << RabbitHutch::MongoConsumer.new(rabbitmq_host, @config)
          when "log4r_consumer"
            consumers << RabbitHutch::Log4rConsumer.new(rabbitmq_host, @config)
          end 
        end
    end
    consumers 
  end
   
  # Start the worker process to listen to a RabbitMq Node 
  def start_worker(rabbitmq_host)
    displayname = rabbitmq_host["displayname"]
    hostname = rabbitmq_host["hostname"]
    username = rabbitmq_host["username"]
    password = rabbitmq_host["password"]
    
    consumers = initialize_consumers(rabbitmq_host)
       
    puts "\tListening to RabbitMq #{displayname}, host: #{hostname}, username #{username}"
    AMQP.connect(:host => hostname, :user => username, :password => password) do |connection|
      channel = AMQP::Channel.new(connection)
      worker = RabbitHutch::Worker.new(channel, @config, consumers)
      worker.start
    end
  end
  
  # Entry Point to the application, Begins queue listener and initializes all consmers
  def start
    begin
      #initialize_consumers
      
      EventMachine.run do
        puts "Initializing RabbitMq Listener"
        @config.rabbitmq_hosts.each do |rabbitmq_host|
          if rabbitmq_host["enabled"] == true
            start_worker(rabbitmq_host)
          end
        end
        Signal.trap("INT"){EventMachine.stop}
        Signal.trap("QUIT"){EventMachine.stop}
        Signal.trap("TERM"){EventMachine.stop}
        Signal.trap("TSTP"){EventMachine.stop}
      end
    rescue Exception=>e
      puts "#{e.message} #{e.backtrace}"
      #@log.error("#{e.message} #{e.backtrace}")
    end
  end

# Kick off the App
start



