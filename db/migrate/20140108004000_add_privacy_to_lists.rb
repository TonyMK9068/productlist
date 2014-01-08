class AddPrivacyToLists < ActiveRecord::Migration
  def change
    add_column :lists, :privacy, :string, default: :global
  end
end
