require File.dirname(__FILE__) + '/../../bootstrap.rb'
require File.dirname(__FILE__) + '/../../lib/models/user.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestUserController < Test::Unit::TestCase
  include Rack::Test::Methods

  context "A User instance" do
    setup do
      @user = User.new
      @user.username = 'simakuutio123'
    end

    should "have a username" do
      assert_equal 'simakuutio123', @user.username
    end
  end
end

