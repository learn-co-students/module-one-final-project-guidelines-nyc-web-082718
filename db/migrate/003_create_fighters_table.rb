class CreateFightersTable < ActiveRecord::Migration[4.2]
  def change
    create_table :fighters do |t|
      t.string :name
      t.integer :wins
      t.string :weightclass
      t.boolean :champ
    end
  end
end
