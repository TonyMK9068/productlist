class AddListToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :list_id, :integer
    add_index :searches, :list_id
  end
end
