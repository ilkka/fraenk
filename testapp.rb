#!/usr/bin/env ruby
# Here's a Sinatra app.
# It uses Bundler.

# bootstrap bundler
require 'bootstrap.rb'

class TestApp < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/public'
  
  get '/' do
    haml :index
  end
end

