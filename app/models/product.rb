class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  

  def self.top_ten
    self.select('products.*').
      select('COUNT(products.product_number) AS amount').
      group('products.product_number').
      order('amount DESC')
  end

end