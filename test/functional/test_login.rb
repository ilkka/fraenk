require File.dirname(__FILE__) + '/../../fraenk.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestLoginHandler < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    FraenkApp
  end

  context "The login handler" do
    should "let user login" do
      # load login form
      get '/login'
      assert last_response.ok?
      post '/login'
      assert last_response.ok?
    end

    context "when user is logged in" do
      should "let user logout" do
      end
    end

    should "let user register for an account" do
    end

    should "handle activation via GET" do
    end

    should "handle activation via POST" do
    end

    should "enable user to resend activation" do
    end

    should "enable user to reset forgotten password" do
    end

  end
end

