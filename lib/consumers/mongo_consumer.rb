# encoding: utf-8
require 'rubygems'
require "mongo"

module RabbitHutch
  class MongoConsumer
      
    def initialize(rabbitmq_host, config)
      puts "\tInitializing MongoDb Consumer"
      @config = config
      @rabbitmq_host = rabbitmq_host
      @host = rabbitmq_host["hostname"]
      @config.consumers.each do |consumer|
        if consumer["name"] == 'mongo_consumer'
          @database_prefix = consumer['database_prefix']
         end
      end
      @database = "#{@database_prefix}#{rabbitmq_host["displayname"]}"
      @port = rabbitmq_host["port"]
      @connection = Mongo::Connection.new(@host, @port)
    end
        
    def log_event(item)
      begin  
        db = @connection.db(@database)
        coll = db.collection(item[:exchange])
        coll.insert(item)
      rescue Exception => e
        puts "Error occurred Message Handler trying to write messages to MONGODB #{e.inspect}" 
      end
    end 
  end
end
