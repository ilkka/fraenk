require File.dirname(__FILE__) + '/../../fraenk.rb'
require File.dirname(__FILE__) + '/../../lib/models/user.rb'
require File.dirname(__FILE__) + '/../helper.rb'

class TestUser < Test::Unit::TestCase
  include Rack::Test::Methods

  context "A User instance" do
    TestUsername1 = 'simakuutio123'
    TestUsername2 = 'dingleberry'
    TestPassword1 = 'gadt4aragga'
    TestPassword2 = '43645yrfadf'

    setup do
      @user = User.new
    end

    should "have a changeable username" do
      @user.username = TestUsername1
      assert_equal TestUsername1, @user.username
      @user.username = TestUsername2
      assert_equal TestUsername2, @user.username
    end

    should "have a changeable password" do
      @user.password = TestPassword1
      assert_equal TestPassword1, @user.password
      @user.password = TestPassword2
      assert_equal TestPassword2, @user.password
    end
  end
end

