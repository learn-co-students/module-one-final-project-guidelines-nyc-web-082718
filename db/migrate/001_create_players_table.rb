class CreatePlayersTable < ActiveRecord::Migration[4.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :gender
      t.string :nickname
      t.string :weightclass
    end
  end
end
