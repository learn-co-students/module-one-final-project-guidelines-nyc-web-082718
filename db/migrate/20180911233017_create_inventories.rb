class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :amount
    end
  end
end
