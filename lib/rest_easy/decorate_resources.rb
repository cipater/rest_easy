module RestEasy
  module DecorateResources
    extend ActiveSupport::Concern

    included do
      decorate_resource resource_name
    end

    def set_resource resource
      super RestEasy.decorator_interface_class.decorate(resource)
    end

    def set_collection collection
      super RestEasy.decorator_interface_class.decorate_collection(collection)
    end

    module ClassMethods
      def decorate_resource name
        RestEasy::DecorateResources.class_eval %Q{
          def undecorated_#{name}
            RestEasy.decorator_interface_class.undecorated_resource #{name}
          end

          def undecorated_#{name.pluralize}
            RestEasy.decorator_interface_class.undecorated_collection #{name.pluralize}
          end
        }
      end
    end

  end
end
