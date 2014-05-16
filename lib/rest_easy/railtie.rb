require 'rails/railtie'

module RestEasy
  class Railtie < ::Rails::Railtie
    config.eager_load_namespaces << RestEasy
  end
end
