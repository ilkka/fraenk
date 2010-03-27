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

  helpers do
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def restrict
      (notify 'You must be logged in to view that page'; redirect '/login') unless current_user
    end

    def notify(msg)
      if Notice.msg.nil? then Notice.msg = msg
      else Notice.msg += '<br/>' + msg
      end
    end

    def notice
      msg = Notice.msg
      Notice.msg = nil; msg
    end
  end

  get '/' do
    haml :index
  end

  get '/restricted' do
    restrict
    haml "You're logged in so you got here"
  end

  get '/show' do
    restrict
    @user = current_user
    haml :show
  end
end

