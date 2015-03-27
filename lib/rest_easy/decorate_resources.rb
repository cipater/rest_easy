module RestEasy
  module DecorateResources
    extend ActiveSupport::Concern

    included do
      decorate_resource resource_name, collection_name
    end

    def set_resource resource
      super decorator_class.decorate(resource)
    end

    def set_collection collection
      super decorator_class.decorate_collection(collection)
    end

    def decorator_class
      RestEasy.configuration.decorator_interface_class
    end

    module ClassMethods
      def decorate_resource resource_name, collection_name
        RestEasy::DecorateResources.class_eval %Q{
          def undecorated_#{resource_name}
            decorator_class.undecorated_resource #{resource_name}
          end

          def undecorated_#{collection_name}
            decorator_class.undecorated_collection #{collection_name}
          end
        }
      end
    end

  end
end
