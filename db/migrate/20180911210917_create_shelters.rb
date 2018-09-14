class CreateShelters < ActiveRecord::Migration[5.0]
  def change
    create_table :shelters do |t|
      t.string :name
      t.integer :character_id
      t.integer :environment_id
      t.string :material
    end
  end
end
