class CustomersController < ApplicationController
  Pry.rescue do
    include RestEasy::Resources
    include RestEasy::Crud
    include RestEasy::DecorateResources
  end

  respond_to :html
end
