require File.dirname(__FILE__) + '/../../fraenk.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestFraenkApp < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    FraenkApp
  end

  context "This application" do
    should "Return a valid index page" do
      get '/'
      assert last_response.ok?
    end
  end
end

