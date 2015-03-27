module RestEasy
  module DecoratorInterfaces
    class Draper
      class << self

        def decorate resource
          "#{resource.class}Decorator".classify.constantize.decorate resource
        end

        def decorate_collection collection
          klass_name = collection.is_a?(Array) ? collection.first.class : collection.name
          # collection = collection.is_a?(ActiveRecord) ? collection : collection.all
          "#{klass_name}Decorator".classify.constantize.decorate_collection collection
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
