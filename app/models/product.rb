class Product < ActiveRecord::Base
  attr_accessible :name, :price, :store, :product_number, :link
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  

  # def self.top_rated
  #   self.select('products.product_number').
  #       select('COUNT(*) AS products_count').
  # end

end
