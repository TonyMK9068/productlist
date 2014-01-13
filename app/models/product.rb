class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products
  
  validates_presence_of :image_url, :product_number, :link, :store, :name

  def receive(message, params)
    message
  end  

  def self.top_ten
    self.select('"product_number", COUNT("product_number") AS "amount"').
      group('product_number').
      having('"amount" > 1').
      order('"amount" DESC').
      collect { |product| Product.find_by_product_number(product.product_number) }.
      first(9)
  end

end