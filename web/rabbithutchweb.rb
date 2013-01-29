require 'sinatra'
require 'haml'
require 'yaml'

get '/' do
  file = File.dirname(__FILE__) + '/../config/config.yaml'
  @config = YAML::load(File.open(file))
  haml :index, :locals => { 
    :app => @config['application'],
    :rabbit => @config['rabbitmq']['hosts'],
    :consumers => @config['consumers_config']['consumers']
  }
end