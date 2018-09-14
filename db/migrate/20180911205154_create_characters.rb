class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :health
      t.integer :hunger
      t.integer :thirst
      t.integer :sleep
    end
  end
end
