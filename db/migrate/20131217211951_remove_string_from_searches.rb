class RemoveStringFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :string
  end
end
