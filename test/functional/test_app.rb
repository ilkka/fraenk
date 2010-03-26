require File.dirname(__FILE__) + '/../../testapp.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp
  end

  context "This application" do
    should "Return a valid index page" do
      get '/'
      assert last_response.ok?
    end
  end
end

