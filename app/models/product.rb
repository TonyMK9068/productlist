class Product < ActiveRecord::Base
  attr_accessible :store, :category, :image_url, :name, :price, :product_number, :link
  belongs_to :list, inverse_of: :products

  def receive(message, params)
    message
  end  

  def self.top_ten
    duplicates = self.find(:all, :group => :product_number, :having => "count(*) > 1", :order => "count(*) DESC").first(10)
  end

end