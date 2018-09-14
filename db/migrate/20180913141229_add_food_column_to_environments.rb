class AddFoodColumnToEnvironments < ActiveRecord::Migration[5.0]
  def change
    add_column :environments, :food_type, :string
  end
end
