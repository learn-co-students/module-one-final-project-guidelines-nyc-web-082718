class CreateCharacterEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :characterenvironments do |t|
      t.integer :character_id
      t.integer :environment_id
    end
  end
end
