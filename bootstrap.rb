# bootstrap bundler and dependencies
begin
  require File.expand_path('.bundle/environment', __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require

# load db config
Environment = ENV['SINATRA_ENV'] || 'development'
DBConfig = YAML::load(File.open('db/config.yml'))[Environment]

# configure datamapper
DataMapper::Logger.new($stdout, :debug)
case DBConfig['adapter']
when 'sqlite3'
  DataMapper.setup(:default, "sqlite3:#{DBConfig['database']}")
end

