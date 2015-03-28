module RestEasy
  module Resources
    extend ActiveSupport::Concern

    module ClassMethods

      def resource_name
        @_resource_name ||= resource_class.name.underscore.singularize
      end

      def resource_class
        @_resource_class ||= controller_name.classify.constantize
      end

      def collection_name
        @_collection_name ||= controller_name
      end

    end



    included do |base|
      puts base
      helper_method :resource_name
      helper_method :collection_name
      helper_method :new_resource_path
      helper_method "#{resource_name}"
      helper_method "#{collection_name}"
      helper_method :resource
      helper_method :collection

      base.class_eval %Q{

        def self.inherited(base)
          base.class_eval %Q{
            puts " --> def'ing \#{base.resource_name}"
            def \#{base.resource_name}
              get_or_set_resource
            end
            alias_method :resource, :\#{base.resource_name}

            def \#{base.collection_name}
              get_or_set_collection
            end
            alias_method :collection, :\#{base.collection_name}
          }
        end

        def #{resource_name}
          get_or_set_resource
        end
        alias_method :resource, :#{resource_name}

        def #{collection_name}
          get_or_set_collection
        end
        alias_method :collection, :#{collection_name}
      }
    end

    private

    def find_or_build_resource_with
      resource_id ? find_resource_with : build_resource_with
    end

    def find_resource_with
      [ :find_by!, id: resource_id ]
    end

    def build_resource_with
      [ build_method, resource_params ]
    end

    def build_method
      parent ? :build : :new
    end

    def parent
      false
    end

    def resource_id
      params[:id]
    end

    def association_chain
      resource_class
    end

    def collection_chain
      association_chain.all
    end

    def resource_chain
      association_chain
    end

    def get_or_set_resource
      get_resource || set_resource(resource_chain.send(*find_or_build_resource_with))
    end

    def get_or_set_collection
      get_collection || set_collection(collection_chain)
    end

    def get_resource
      instance_variable_get "@#{resource_name}"
    end

    def set_resource resource
      instance_variable_set "@#{resource_name}", resource
    end

    def get_collection
      instance_variable_get "@#{collection_name}"
    end

    def set_collection collection
      instance_variable_set "@#{collection_name}", collection
    end

    def collection_name
      self.class.collection_name
    end

    def resource_name
      self.class.resource_name
    end

    def resource_class
      self.class.resource_class
    end

    def new_resource_path
      [ :new ] + nested_path + [ resource_name ]
    end

    def resource_request_name
      resource_class.to_s.underscore.gsub('/', '_')
    end

    def resource_params_name
      params[resource_request_name].nil? ? resource_request_name : resource_name
    end

    def resource_params
      return {} unless params.has_key?(resource_params_name)
      params.require(resource_params_name).permit *permitted_attributes
    end

  end
end
