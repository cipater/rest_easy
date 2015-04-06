module RestEasy
  module DecoratorInterfaces
    class Draper
      attr_reader :klass

      def initialize klass
        @klass = "#{klass}Decorator".classify.constantize
      end

      def decorate resource
        klass.decorate resource
      end

      def decorate_collection collection
        klass.decorate_collection collection
      end

    end
  end
end
