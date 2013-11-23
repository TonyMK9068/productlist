class AddTitleToLists < ActiveRecord::Migration
  def change
    add_column :lists, :title, :string
    remove_column :lists, :name
  end
end
