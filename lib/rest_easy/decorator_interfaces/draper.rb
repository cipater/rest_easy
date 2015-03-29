module RestEasy
  module DecoratorInterfaces
    class Draper
      attr_reader :klass

      def initialize klass
        @klass = klass.name
      end

      def decorate resource
        "#{klass}Decorator".classify.constantize.decorate resource
      end

      def decorate_collection collection
        "#{klass}Decorator".classify.constantize.decorate_collection collection
      end

    end
  end
end
