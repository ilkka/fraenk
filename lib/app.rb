# vim:filetype=ruby
class FraenkApp < Sinatra::Base
  set :sessions, true
  set :public, File.dirname(__FILE__) + '/../public'
 
  configure do
    @dbconfig = YAML::load(File.open 'db/config.yml')[environment.to_s]
    DataMapper::Logger.new($stdout, :debug)
    case @dbconfig['adapter']
    when 'sqlite3'
      DataMapper.setup(:default, "sqlite3:#{@dbconfig['database']}")
    end
  end

  before do
    @title = "Sinatra + Haml + Bundler test"
    @subtitle ="Just a bit of something I got up to one day"
  end

  get '/' do
    haml :index
  end
end

