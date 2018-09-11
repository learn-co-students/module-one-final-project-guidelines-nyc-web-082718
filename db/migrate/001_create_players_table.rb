class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :gender
      t.string :nickname
      t.string :weightclass
    end
  end
end
