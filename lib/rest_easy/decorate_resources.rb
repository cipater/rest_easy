module RestEasy
  module DecorateResources
    extend ActiveSupport::Concern

    included do
      decorate_resource resource_name, collection_name

      helper_method "undecorated_#{resource_name}"
      helper_method "undecorated_#{collection_name}"
    end

    def set_resource resource
      instance_variable_set "@undecorated_#{resource_name}", resource
      super decorator_interface_class.decorate(resource)
    end

    def set_collection collection
      instance_variable_set "@undecorated_#{collection_name}", collection
      super decorator_interface_class.decorate_collection(collection)
    end

    def decorator_interface_class
      RestEasy.configuration.decorator_interface_class.new(decorator_resource_class)
    end

    def decorator_resource_class
      resource_class
    end

    module ClassMethods
      def decorate_resource resource_name, collection_name
        RestEasy::DecorateResources.class_eval %Q{
          def undecorated_#{resource_name}
            get_or_set_resource
            @undecorated_#{resource_name}
          end

          def undecorated_#{collection_name}
            get_or_set_collection
            @undecorated_#{collection_name}
          end
        }
      end
    end

  end
end
