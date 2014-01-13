class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products
  
  validates_presence_of :image_url, :product_number, :link, :store, :name

  def receive(message, params)
    message
  end  

  def self.top_ten
    self.group(self).having('COUNT(products.product_number) > 1').order('COUNT(products.product_number) DESC').first(9)
      #select('product_number, COUNT(product_number) AS amount').
      #order('"amount" DESC').
      #collect { |product| Product.find_by_product_number(product.product_number) }.
  end

end