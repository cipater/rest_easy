module RestEasy
  module Crud
    extend ActiveSupport::Concern

    def index
      respond_with_object send(collection_name)
    end

    def new
      respond_with_object send(resource_name)
    end

    def show
      respond_with_object send(resource_name)
    end

    def edit
      respond_with_object send(resource_name)
    end

    def create
      object = send(resource_name)

      if create_resource(object)
        if request.xhr?
          flash.now[:notice] = "#{resource_name.humanize} was successfully created."
        else
          flash[:notice] = "#{resource_name.humanize} was successfully created."
        end

        yield object if block_given?
      end

      respond_with_object object
    end

    def update
      object = send(resource_name)

      if update_resource object, resource_params
        if request.xhr?
          flash.now[:notice] = "#{resource_name.to_s.humanize} was successfully updated."
        else
          flash[:notice] = "#{resource_name.to_s.humanize} was successfully updated."
        end

        yield object if block_given?
      end

      respond_with_object object
    end

    def destroy
      object = send(resource_name)

      destroy_resource object

      if object.destroyed?
        if request.xhr?
          flash.now[:notice] = "#{resource_name.to_s.humanize} was successfully deleted."
        else
          flash[:notice] = "#{resource_name.to_s.humanize} was successfully deleted."
        end
      end

      respond_with_object object
    end

    private

    # Responsible for saving the resource on :create method. Overwriting this
    # allow you to control the way resource is saved. Let's say you have a
    # PassworsController who is responsible for finding an user by email and
    # sent password instructions for him. Instead of overwriting the entire
    # :create method, you could do something:
    #
    #   def create_resource object
    #     object.send_instructions_by_email
    #   end
    #
    def create_resource object
      object.save
    end

    # Responsible for updating the resource in :update method. This allow you
    # to handle how the resource is gona be updated, let's say in a different
    # way then the usual :update_attributes:
    #
    #   def update_resource object, attributes
    #     object.reset_password!(attributes)
    #   end
    #
    def update_resource object, attributes
      object.update attributes
    end

    # Handle the :destroy method for the resource. Overwrite it to call your
    # own method for destroing the resource, as:
    #
    #   def destroy_resource object
    #     object.cancel
    #   end
    #
    def destroy_resource object
      object.destroy
    end

    def respond_with_object object
      respond_with *object_with_nested_path(object)
    end

    def object_with_nested_path object
      nested_path + [object]
    end

    def nested_path
      defined?(super) ? super : self.class.to_s.deconstantize.split('::').collect(&:underscore).collect(&:to_sym)
    end

  end
end
