ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment",  __FILE__)
require 'rest_easy'
require 'rspec/rails'

# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
