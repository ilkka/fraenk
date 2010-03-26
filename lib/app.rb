# vim:filetype=ruby
class TestApp < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/../public'
  
  get '/' do
    haml :index
  end
end

