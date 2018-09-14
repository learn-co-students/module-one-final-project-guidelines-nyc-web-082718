class AddCharacterIdToInventories < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :character_id, :integer
  end
end
