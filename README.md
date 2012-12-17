#rabbit-hutch

RabbitMq Trace Logger

# Overview
	
	This is a ruby service for monotoring the trace output on RabbitMq Nodes and writing the output to console, Log files or MongoDb

#Technologies Used
	
	*Ruby
	*Deamonizr
	
# Setup & Installation

	gem install rabbithutch
	
	Run as a command line process
	rabbithutch run 
	
	Run as a service
	rabbithutch start 
	
	For help
	rabbithutch

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


References
	
