class CreateLongWords < ActiveRecord::Migration[5.0]
  def change
    create_table :long_words do |t|
      t.string :word
      t.integer :length
      t.integer :syllables
    end
  end
end
