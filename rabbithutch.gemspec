# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = %q{rabbithutch}
  gem.version       = "0.0.7"
  gem.authors       = ["John Ryan"]
  gem.email         = ["555john@gmail.com"]
  gem.description   = %q{RabbitMq Trace Logger - Listen to multiple RabbitMq instances and log them to a 
single location or MongoDb database. }
  gem.summary       = %q{A ruby service for monotoring the trace output on RabbitMq Nodes and writing the output to console, Log files or MongoDb}
  gem.homepage      = %q{http://github.com/jnyryan/}
  
  gem.extra_rdoc_files = ["LICENSE.txt","README.md"  ]
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.executable    = 'rabbithutch'
  gem.require_paths = ["lib"]
  
  gem.rdoc_options << '--exclude spec/testfiles'
  
  gem.add_dependency "amqp"
  gem.add_dependency "bson_ext"
  gem.add_dependency "daemons"
  gem.add_dependency "eventmachine"
  gem.add_dependency "logger"
  gem.add_dependency "log4r"
  gem.add_dependency "mq"
  gem.add_dependency "mongo"
  gem.add_dependency "mongo_ext"
  gem.add_dependency "thor"
  gem.add_dependency "yard"

end
