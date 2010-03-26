#!/usr/bin/env ruby
# Here's a Sinatra app.
# It uses Bundler.

# bootstrap bundler
begin
  require File.expand_path('.bundle/environment', __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require

class TestApp < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/public'
  
  get '/' do
    haml :index
  end
end

