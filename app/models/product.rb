class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  

  def self.top_rated
    self.select("products.*, COUNT(products.id) AS amount").
      group("product_number").having("amount > 1").
      order("amount DESC LIMIT 10")
  end
end
