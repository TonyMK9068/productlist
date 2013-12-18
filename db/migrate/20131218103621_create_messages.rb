class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.string :recipient

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
