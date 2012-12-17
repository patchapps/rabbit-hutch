# encoding: utf-8
require 'rubygems'
require "mongo"

module RabbitHutch
  class ConsoleConsumer
      
    def initialize()
      puts "\tInitializing Console Consumer"
    end
        
    def log_event(item)
      begin  
        puts item
      rescue Exception => e
        puts "Error occurred Message Handler trying to write messages to Log #{e.inspect}" 
      end
    end 
  end
end
