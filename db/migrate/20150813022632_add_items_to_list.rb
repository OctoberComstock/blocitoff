class AddItemsToList < ActiveRecord::Migration
  def change
    add_column :lists, :item_id, :integer
    add_index :lists, :item_id
  end
end
