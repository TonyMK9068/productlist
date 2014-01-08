class AddPrivacyToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :privacy, :string, default: :global
  end
end
