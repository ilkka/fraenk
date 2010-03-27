# vim:filetype=ruby

# authlogic bug workaround
# see http://github.com/binarylogic/authlogic/issuesearch?state=open&q=remote_ip#issue/80
class Sinatra::Request
  alias remote_ip ip
end

# A Notice struct
Notice = Struct.new(:msg).new

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
    @title = "Sinatra + Haml + Bundler test"
    @subtitle ="Just a bit of something I got up to one day"
  end

  get '/' do
    haml :index
  end
end

