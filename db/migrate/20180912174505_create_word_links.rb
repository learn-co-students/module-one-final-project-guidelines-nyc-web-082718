class CreateWordLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :word_links do |t|
      t.integer :short_word_id
      t.integer :long_word_id
      t.string :link_type
    end
  end
end
