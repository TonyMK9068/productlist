class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :store
      t.belongs_to :list

      t.timestamps
    end
    add_index :products, :list_id
  end
end
