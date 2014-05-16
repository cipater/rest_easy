class Product
  include ActiveModel::Model

  attr_accessor :id

  def initialize id = nil
    @id = id
  end

  def persisted?
    true
  end
end
