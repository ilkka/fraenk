# vim:filetype=ruby
class TestApp < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/../public'
 
  before do
    @title = "Sinatra + Haml + Bundler test"
    @subtitle ="Just a bit of something I got up to one day"
  end

  get '/' do
    haml :index
  end
end

