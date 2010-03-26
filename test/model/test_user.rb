require File.dirname(__FILE__) + '/../../bootstrap.rb'
require File.dirname(__FILE__) + '/../../lib/model/user.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestUserController < Test::Unit::TestCase
  include Rack::Test::Methods

  context "A User instance" do
    @user = User.new
  end
end

