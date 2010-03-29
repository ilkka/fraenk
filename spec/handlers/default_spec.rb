require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'The default handler' do
  def app
    @app ||= FraenkApp
  end

  it "should return a valid index page" do
    get '/'
    last_response.should be_ok
  end
end

