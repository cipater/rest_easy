module RestEasy
  module DecoratorInterfaces
    class Null

      def decorate resource
        resource
      end

      def decorate_collection collection
        collection
      end

    end
  end
end
