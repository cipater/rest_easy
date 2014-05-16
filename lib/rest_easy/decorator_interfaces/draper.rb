module RestEasy
  module DecoratorInterfaces
    class Draper
      class << self

        def decorate resource
          "::#{resource}Decorator".classify.decorate resource
        end

        def decorate_collection collection
          "::#{resource}Decorator".classify.decorate_collection
        end

        def undecorated_resource resource
          resource.model
        end

        def undecorated_collection collection
          collection.collect(&:model)
        end

      end
    end
  end
end
