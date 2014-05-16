$: << File.dirname(__FILE__)

require 'rest_easy/version'
require 'rest_easy/resources'
require 'rest_easy/crud'
require 'rest_easy/decorate_resources'
require 'rest_easy/decorator_interfaces/draper'
require 'rest_easy/decorator_interfaces/null'
require 'rest_easy/pagination'
# require 'rest_easy/railtie' if defined?(Rails)
require 'rest_easy/base'

module RestEasy

  attr_accessor :decorator_interface_class
  @@decorator_interface_class = RestEasy::DecoratorInterfaces::Null

  def self.configure
    yield self
  end

end
