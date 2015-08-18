class AddListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :list_id, :integer
    add_index :users, :list_id
  end
end
