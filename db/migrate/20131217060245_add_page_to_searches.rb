class AddPageToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :page, :integer
  end
end
