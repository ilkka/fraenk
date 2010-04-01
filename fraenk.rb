#!/usr/bin/env ruby
# Here's a Sinatra app.
# It uses Bundler.

# bootstrap bundler
require 'bootstrap.rb'

# load models and handlers
Dir.glob(File.join(File.dirname(__FILE__), 'lib', '*', '*.rb')).each do |file|
  require file
end

# load my app lib
require 'lib/app.rb'

