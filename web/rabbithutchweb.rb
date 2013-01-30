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

post '/rabbitmqsettingsadd/add' do
  haml :rabbitmqsettings, :locals=>{:settings=>params} 
end

post '/rabbitmqsettingsedit/edit' do
  haml :rabbitmqsettings, :locals=>{:settings=>params} 
end

post '/rabbitmqsettingsedit/save' do
  redirect "/"
end