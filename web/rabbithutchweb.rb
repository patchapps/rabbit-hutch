require 'sinatra'
require 'haml'
require 'yaml'

module RabbitHutchWeb
  class RabbitSettings
    
    attr_accessor :settings, :application, :rabbitmq_hosts, :consumers
    
    def initialize
      file = File.dirname(__FILE__) + '/../configs/config2.yaml'
      @settings = YAML::load(File.open(file))
      @application = settings['application']
      @rabbitmq_hosts = settings['rabbitmq']['hosts']
      @consumers = settings['consumers_config']['consumers']
    end
    
    def save
      file = File.dirname(__FILE__) + '/../configs/config2.yaml'
      File.open(file, "w") do|f|
        f.write self.settings.to_yaml
      end
    end
  end
end

get '/' do
  settings = RabbitHutchWeb::RabbitSettings.new
  
  haml :index, :locals => { 
    :app => settings.application,
    :rabbit => settings.rabbitmq_hosts,
    :consumers => settings.consumers
  }
end

get '/rabbitmqsettings/add' do
  settings = RabbitHutchWeb::RabbitSettings.new
  params["id"] = settings.rabbitmq_hosts.length + 1
  haml :rabbitmqsettings, :locals=>{:settings=>params} 
end

get '/rabbitmqsettings/edit/:id' do |id| 
  setting = nil
  settings = RabbitHutchWeb::RabbitSettings.new
  settings.rabbitmq_hosts.each{|item| setting = item if item["id"]==id.to_i }
  haml :rabbitmqsettings, :locals=>{:settings=>setting} 
end

post '/rabbitmqsettings/save' do
  p "saving"
  exists = false
  settings = RabbitHutchWeb::RabbitSettings.new
  settings.rabbitmq_hosts.each{|item|
    if item["id"]==params["id"].to_i 
      item["displayname"] = params["displayname"]
      item["enabled"] = params["enabled"]
      item["hostname"] = params["hostname"]
      item["username"] = params["username"]
      item["password"] = params["password"]
      exists = true
    end
  }
  
  unless exists
    
    setting = 
    {
    "id" => params["id"],
    "displayname" => params["displayname"],
    "enabled" => params["enabled"],
    "hostname" => params["hostname"],
    "username" => params["username"],
    "password" => params["password"]
    }
    
    settings.rabbitmq_hosts << setting
  end
    
  settings.save
  redirect "/"
end

post '/rabbitmqsettings/delete' do
  redirect "/"
end
