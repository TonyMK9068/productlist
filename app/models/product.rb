class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  


  def self.top_rated
    top_10 = self.select("id, COUNT(product_number) AS amount").
      group("product_number").having("amount > 1").
      order("amount DESC LIMIT 10").all
    instances = top_10.collect do |instance|
      Product.find(instance.id)
    end
  end
end