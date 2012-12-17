require "rubygems"
require "amqp"
require_relative "configurator"
require_relative "consumer"

module RabbitHutch
  @exchange_name = "amq.rabbitmq.trace"
  
  class Worker
    
    def initialize(channel, config, consumers)
      @channel = channel
      @channel.on_error(&method(:handle_channel_exception))
      @consumer = Consumer.new(consumers)
      @exchange_name = config.application['exchangename']
      @queue_name = config.application['queuename']
    end
  
    def start
      @exchange = @channel.topic(@exchange_name, :durable => true, :auto_delete => false, :internal => true)
      @queue = @channel.queue(@queue_name, :durable => false, :auto_delete => true)
      @queue.bind(@exchange, :routing_key => '#')
      @queue.subscribe(&@consumer.method(:handle_message))
    end
  
    def handle_channel_exception(channel, channel_close)
      puts "Oops... a channel-level exception: code = #{channel_close.reply_code}, message = #{channel_close.reply_text}"
    end
    
  end
  
end