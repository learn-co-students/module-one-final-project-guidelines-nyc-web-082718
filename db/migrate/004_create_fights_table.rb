class CreateFightsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :fights do |t|
      t.integer :fighter_id
      t.integer :user_id
    end
  end
end
