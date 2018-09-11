class CreateEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :environments do |t|
      t.string :type
      t.boolean :water
      t.string :resource
    end
  end
end
