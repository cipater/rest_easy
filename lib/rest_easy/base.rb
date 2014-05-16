module RestEasy
  module Base
    extend ActiveSupport::Concern
    include RestEasy::Resources
    include RestEasy::Crud
  end
end
