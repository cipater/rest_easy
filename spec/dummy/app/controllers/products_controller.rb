class ProductsController < ApplicationController
  Pry.rescue do
    include RestEasy::Resources
    include RestEasy::Crud
  end
end
