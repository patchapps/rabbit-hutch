require "rubygems"
require_relative "configurator"
require_relative "consumers/mongo_consumer"

module RabbitHutch
  # Controls the consumers that are to be kicked off based on the config file
  class Consumer
    def initialize(consumers)
      @consumers = consumers
    end
    
    # Raised on receipt of a message from RabbitMq and uses the appropriate appender
    def handle_message(metadata, payload)
       # loop through appenders and fire each as required
       @consumers.each do |consumer|
         action = metadata.routing_key.split('.', 2).first
         if(action == "publish")
           exchange = metadata.attributes[:headers]["exchange_name"]
           queue = metadata.routing_key.split('.', 2).last
           item = {:date => Time.now, 
                :exchange => exchange,
                :queue => queue,
                :routing_keys => metadata.attributes[:headers]["routing_keys"].inspect,
                :attributes => metadata.attributes.inspect,
                :payload => payload.inspect
           }
           consumer.log_event(item)
         end 
       end
    end
  end
end