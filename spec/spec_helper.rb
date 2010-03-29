require File.join(File.dirname(__FILE__) , '..', 'fraenk.rb')

require 'spec/autorun'
require 'spec/interop/test'

# configure test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

