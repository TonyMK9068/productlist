class AddLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :link, :string
    add_column :products, :product_number, :string
  end
end
