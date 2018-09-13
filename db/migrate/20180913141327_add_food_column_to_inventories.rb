class AddFoodColumnToInventories < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :food, :integer
  end
end
