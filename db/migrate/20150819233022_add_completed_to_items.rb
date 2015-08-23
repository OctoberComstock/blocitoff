class AddCompletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :completed, :boolean
    add_column :items, :expires_at, :datetime
  end
end
