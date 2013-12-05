class AddCategoryAndImageUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category, :string
    add_column :products, :image_url, :string
  end
end
