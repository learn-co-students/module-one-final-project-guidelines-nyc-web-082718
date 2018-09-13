class CreateShortWords < ActiveRecord::Migration[5.0]
  def change
    create_table :short_words do |t|
      t.string :word
      t.integer :length
      t.string :tags
      t.integer :numSyllables
    end
  end
end
