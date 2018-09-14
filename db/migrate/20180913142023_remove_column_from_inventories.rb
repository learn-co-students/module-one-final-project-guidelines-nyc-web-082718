class RemoveColumnFromInventories < ActiveRecord::Migration[5.0]
  def change
    remove_column :inventories, :food
  end
end
