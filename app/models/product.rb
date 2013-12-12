class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
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
