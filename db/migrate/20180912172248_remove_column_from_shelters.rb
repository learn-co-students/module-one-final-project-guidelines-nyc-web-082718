class RemoveColumnFromShelters < ActiveRecord::Migration[5.0]
  def change
    remove_column :shelters, :name
  end
end
