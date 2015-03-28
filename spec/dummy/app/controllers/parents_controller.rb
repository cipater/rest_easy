class ParentsController < ApplicationController
  Pry.rescue do
    include RestEasy::Resources
    include RestEasy::Crud
  end

  respond_to :html
end
