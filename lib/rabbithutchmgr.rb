require 'thor'
require 'mustache'
require_relative 'configurator.rb'

module RabbitHutch
  #This class controls the Command Line Interface
  class CLI < Thor
    
StandardTemplate =<<-TEMPLATE
{{#config}}

{{#application}}
Application
+------------------------+------------------------+
|Exchange                |Queue                   |
+------------------------+------------------------+
|{{exchangename}}        |  {{queuename}}         |
+------------------------+------------------------+
{{/application}}

{{#rabbitmq}}
RabbitMq Servers
+------------------------+------------------------+
|Display Name                |Host                   |
+------------------------+------------------------+
{{#hosts}}
|{{displayname}}        |  {{hostname}}         |
+------------------------+------------------------+
{{/hosts}}
{{/rabbitmq}}

{{/config}}
TEMPLATE

    desc "list", "List all config settings"
    #method_option :errors, :aliases => "-e", :type => :boolean, :default => false, :desc => "true = display files that could not be processed, false = do not display skipped files"
    #method_option :hashtype, :aliases => "-h", :default => "cmd5", :desc => "Choose the hash algorithm to use - md5 or sha"
    method_option :config, :aliases => "-c", :default => nil, :desc => "parse the config file from a specified location "
    #method_option :recursive, :aliases => "-r", :type => :boolean, :default => "false", :desc => "true = recurse through sub directories, false = only do top directory"
    def list()
      @config = RabbitHutch::Configurator.new(options)
      puts Mustache.render(StandardTemplate,  :config => @config);
    end
    
  end  
  
  CLI.start()
end