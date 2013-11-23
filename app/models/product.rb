class Product < ActiveRecord::Base
  attr_accessible :name, :price, :store
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end
  
end
