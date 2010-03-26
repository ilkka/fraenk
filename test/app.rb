require '../testapp'

class TestAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "This application" do
    should "Return a valid index page" do
      get '/'
      assert_equal "Hello world!", last_response.body
    end
  end
end

