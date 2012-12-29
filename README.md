#rabbit-hutch

RabbitMq Trace Logger - Listen to multiple RabbitMq instances and log them to a 
single location or MongoDb database. 

# Overview
	
A ruby service for monotoring the trace output on RabbitMq Nodes and writing the 
output to console, Log files or MongoDb.

Once tracing is started on the target rabbitMQ nodes, the service creates a queue 
"rabbithutch" that binds to the exchange "amq.rabbitmq.trace". All messages that arrive
on the queue are then picked up by any registered consumers and written to standard 
output, a log file or a MongoDb Database.
	
# Environment

	This has been tested on 
	* Ubuntu Linux
	* Windows 8
	
# Installation
	
	##Activate tracing on rabbitmq server
	
	run the following command on each server you want to trace
	rabbitmqctl trace_on
	
	##Install the rabbit-hutch service
	
	gem install rabbithutch

#RabbitMq Configuration

	In order for tracing to work, the trace_on option must be enabled on all rabbitMq nodes.
	Turn on tracing on the nodes using the following command:
	rabbitmqctl trace_on
	
# Usage

	Run as a command line process with a config file
	rabbithutch run -- ~/config.yaml
	
	Run as a service
	rabbithutch start -- ~/config.yaml
	
	For help on the service
	rabbithutch
	
# Configuration

	To add RabbitMq nodes to monitor and consumers to enable you will need to change the configuration.
	
	The config below shows two RabbitMq nodes with each with console, mongoDb and log file consumers
	
	./config.yaml
	
	application:
    exchangename: amq.rabbitmq.trace
    queuename: rabbithutch
    
	rabbitmq:
		hosts:
		  - displayname: local1
			enabled: true
			hostname: 127.0.0.1
			username: guest
			password: guest
		  - displayname: local2
			enabled: false
			hostname: 127.2.2.2
			username: guest
			password: guest

	consumers_config:
		consumers:
		  - name: console_consumer
			enabled: true
		  - name: mongo_consumer
			enabled: true
			hostname: 127.0.0.1
			username: guest
			password: guest
			database_prefix: rhutch_
			port: 27017
		  - name: log4r_consumer
			enabled: true
			log_location: /tmp
			log_prefix: rhutch_
	
#Contributing
	
	Fork it
	Create your feature branch (git checkout -b my-new-feature)
	Commit your changes (git commit -am 'Add some feature')
	Push to the branch (git push origin my-new-feature)
	Create new Pull Request

## Create the gem
	
	Build and Test Locally
	-gem build rabbithutch.gemspec
	-gem install rabbithutch-X.X.X # where X.X.X is the version of the compiled gemspec
	
	Build and deploy to rubygems.org
	-gem update --system
	-gem build rabbithutch.gemspec
	-gem push rabbithutch-0.0.1.gem # where X.X.X is the version of the compiled gemspec

#To do

	- [ ] Add Http Appender to post messages to url e.g. pastebin.org or mongodb REST interface
	- [ ] Come up with better config mgt for gems like adding a management Command Line Interface to set env settings

