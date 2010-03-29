require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'The login handler' do
  def app
    @app ||= FraenkApp
  end

  it "should return a valid login form" do
    get '/login'
    last_response.should be_ok
    post '/login'
    assert last_response.ok?
  end

  it "should let user register for an account" do
  end

  it "should handle activation via GET" do
  end

  it "should handle activation via POST" do
  end

  it "should enable user to resend activation" do
  end

  it "should enable user to reset forgotten password" do
  end

  context "when user is logged in" do
    it 'should let user log out' do
    end
  end
end

