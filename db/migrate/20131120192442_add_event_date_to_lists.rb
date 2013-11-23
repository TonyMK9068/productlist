class AddEventDateToLists < ActiveRecord::Migration
  def change
    add_column :lists, :event_date, :date
  end
end
