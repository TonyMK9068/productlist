class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products
  
  validates_presence_of :image_url, :product_number, :link, :store, :name

  def receive(message, params)
    message
  end  

  def self.top_ten
    select('product_number, count(product_number) as amount').
      group('product_number').
      having('count(product_number) > 1').
      order('amount desc').
      collect { |product| Product.find_by_product_number(product.product_number) }.first(9)
  end

end