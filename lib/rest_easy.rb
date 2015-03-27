$: << File.dirname(__FILE__)

require 'rest_easy/version'
require 'rest_easy/resources'
require 'rest_easy/crud'
require 'rest_easy/decorate_resources'
require 'rest_easy/decorator_interfaces/draper'
require 'rest_easy/decorator_interfaces/null'
require 'rest_easy/pagination'
require 'rest_easy/base'
require 'rest_easy/configuration'

module RestEasy

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
