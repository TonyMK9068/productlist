class Product < ActiveRecord::Base
  attr_accessible :name, :price, :store, :product_number, :link, :image_url, :category
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  

  def self.top_rated
    self.select("products.* , COUNT(products.product_number) AS amount").
      group("products.product_number").
      order("amount DESC LIMIT 10")
  end
end
