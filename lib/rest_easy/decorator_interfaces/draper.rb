module RestEasy
  module DecoratorInterfaces
    class Draper
      class << self

        def decorate resource
          "#{resource.class}Decorator".classify.constantize.decorate resource
        end

        def decorate_collection collection
          klass_name = collection.is_a?(Array) ? collection.first.class : collection.name
          "#{klass_name}Decorator".classify.constantize.decorate_collection collection
        end

      end
    end
  end
end
