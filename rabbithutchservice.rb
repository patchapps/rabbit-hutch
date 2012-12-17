require 'rubygems'
require 'daemons'

# The Service controller.
def start_service
  begin
    Daemons.run(File.dirname(__FILE__) + '/lib/rabbithutch.rb')
  rescue SystemExit=>e
    puts e.inspect
  rescue Exception=>e
    puts e.inspect
  end
end

start_service()

