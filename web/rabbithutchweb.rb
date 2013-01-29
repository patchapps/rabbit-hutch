require 'sinatra'
require 'haml'
require 'yaml'

get '/' do
  file = File.dirname(__FILE__) + '/../config/config.yaml'
  @config = YAML::load(File.open(file))
  haml :index, :locals => { :cs => @config['rabbitmq']['hosts'] }
end