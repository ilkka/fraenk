require File.dirname(__FILE__) + '/../../testapp.rb'
require 'rack/test'
require 'shoulda'

class TestAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp
  end

  context "This application" do
    should "Return a valid index page" do
      get '/'
      assert_equal "Hello world!", last_response.body
    end
  end
end

