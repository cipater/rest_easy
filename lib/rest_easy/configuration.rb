module RestEasy
  class Configuration
    attr_accessor :decorator_interface_class

    def initialize
      @decorator_interface_class = RestEasy::DecoratorInterfaces::Null
    end
  end
end
