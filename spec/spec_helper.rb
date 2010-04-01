require File.join(File.dirname(__FILE__), '..', 'fraenk.rb')

require 'spec/autorun'
require 'spec/interop/test'
require 'rack/test'

# configure test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

# mix in the rack test stuff
Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
end

