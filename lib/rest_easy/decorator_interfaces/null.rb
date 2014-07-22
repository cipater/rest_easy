module RestEasy
  module DecoratorInterfaces
    class Null
      class << self

        def decorate resource
          resource
        end

        def decorate_collection collection
          collection
        end

        def undecorated_resource resource
          resource
        end

        def undecorated_collection collection
          collection
        end

      end
    end
  end
end